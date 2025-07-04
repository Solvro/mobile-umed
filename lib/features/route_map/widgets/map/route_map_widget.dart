import "dart:io";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart" hide Route;
import "package:flutter_foreground_task/flutter_foreground_task.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_map_location_marker/flutter_map_location_marker.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:latlong2/latlong.dart";

import "../../../../app/config/flutter_map_config.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/theme/app_theme.dart";
import "../../../../common/models/landmark.dart";
import "../../../../common/models/route.dart";
import "../../../../common/providers/cache_tile.dart";
import "../../../../common/utils/location_service.dart";
import "../../controllers/route_controller.dart";
import "../../services/flutter_foreground_task.dart";
import "../../services/task_handlers/route_background_task_handler.dart";
import "../modals/landmark_info_modal.dart";
import "../modals/route_completed_modal.dart";
import "route_map_marker.dart";
import "route_map_polyline.dart";

final mapControllerProvider = Provider.autoDispose((ref) => MapController());

class RouteMapWidget extends ConsumerStatefulWidget {
  const RouteMapWidget({super.key, this.route, this.active = true});

  final Route? route;

  final bool active;

  @override
  RouteMapWidgetState createState() => RouteMapWidgetState();
}

class RouteMapWidgetState extends ConsumerState<RouteMapWidget> {
  Future<void> _onReceiveTaskData(Object data, WidgetRef ref) async {
    if (!mounted) {
      return;
    }
    if (data is String) {
      final event = TaskEvent.fromString(data);
      switch (event) {
        case TaskEvent.nextLocationReached:
          ref.read(visitedCountProvider.notifier).incrementVisited();
        case TaskEvent.routeCompleted:
          await showDialog<RouteCompletedModal>(context: context, builder: (context) => const RouteCompletedModal());
          await FlutterForegroundTask.stopService();
          ref.read(visitedCountProvider.notifier).resetVisited();
        case TaskEvent.error:
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $data")));
      }
    }
  }

  @override
  void initState() {
    if (Platform.isAndroid) {
      FlutterForegroundTask.addTaskDataCallback((data) => _onReceiveTaskData(data, ref));
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await MyFlutterForegroundTask.requestPermissions();
        await LocationService.requestPermissions();
        MyFlutterForegroundTask.initMyService();
        await MyFlutterForegroundTask.startMyForegroundService();
        if (widget.route != null) {
          FlutterForegroundTask.sendDataToTask(widget.route!.landmarks.map((e) => e.toJson()).toList());
        }
      });
    }
    // TODO(tomasz-trela): Implement iOS logic
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final route = widget.route;
    final tileProvider = ref.watch(cacheTileProvider);
    final visitedCount = ref.watch(visitedCountProvider);
    final landmarks = route?.landmarks ?? const IListConst([]);
    final lineChangeIndex = calculateLineChangeFromLandmarksLatLng(
      landmarks: landmarks,
      route: route?.route ?? IList<LatLng>(),
      visited: visitedCount,
    );
    final mapController = ref.watch(mapControllerProvider);

    return switch (tileProvider) {
      AsyncData(:final value) =>
        landmarks.isEmpty
            ? FlutterMap(
              options: const MapOptions(initialCenter: MapConfig.wroclawCenter),
              mapController: mapController,
              children: [TileLayer(urlTemplate: FlutterMapConfig.urlTemplate, maxZoom: 19)],
            )
            : FlutterMap(
              mapController: mapController,
              options: MapOptions(initialCenter: landmarks.first.location),
              children: [
                TileLayer(urlTemplate: FlutterMapConfig.urlTemplate, tileProvider: value, maxZoom: 19),
                RouteMapPolyline(
                  locations: route!.route,
                  doneColor: context.colorScheme.primary,
                  notDoneColor: MapConfig.unvisitedColor,
                  inactiveColor: MapConfig.inactiveColor,
                  active: widget.active,
                  visited: lineChangeIndex,
                ),
                const CurrentLocationLayer(
                  style: LocationMarkerStyle(
                    marker: DefaultLocationMarker(color: Colors.blue),
                    markerSize: Size(28, 28),
                    accuracyCircleColor: Color(0x2288B4EA),
                    headingSectorColor: Color(0x4488B4EA),
                  ),
                ),
                MarkerLayer(
                  markers:
                      landmarks.asMap().entries.map((entry) {
                        final index = entry.key;
                        final landmark = entry.value;
                        Alignment? alignment;
                        if (index == 0 || index == landmarks.length - 1) {
                          alignment = index == 0 ? Alignment.center : Alignment.topRight;
                        }
                        return _buildMarkers(
                          context: context,
                          landmark: landmark,
                          index: index,
                          visitedCount: visitedCount,
                          active: widget.active,
                          totalLandmarks: landmarks.length,
                          markerAlignment: alignment ?? Alignment.topCenter,
                        );
                      }).toList(),
                ),
              ],
            ),

      AsyncError(:final error) => Center(child: Text("error: $error")),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }

  Marker _buildMarkers({
    required BuildContext context,
    required Landmark landmark,
    required int index,
    required int visitedCount,
    required bool active,
    required int totalLandmarks,
    required Alignment markerAlignment,
  }) {
    return Marker(
      alignment: markerAlignment,
      width: MapConfig.markerSize,
      height: MapConfig.markerSize,
      point: landmark.location,
      rotate: true,
      child: GestureDetector(
        onTap:
            active
                ? () async => showDialog<LandmarkInfoModal>(
                  context: context,
                  builder: (context) => LandmarkInfoModal(landmark: landmark),
                )
                : null,
        child: RouteMapMarker(
          type: landmark.type,
          active: active,
          start: index == 0,
          finish: index == totalLandmarks - 1,
          visited: visitedCount - 1 >= index,
          order: index,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class MyFlutterForegroundTask {
  static Future<ServiceRequestResult> startMyForegroundService() async {
    if (await FlutterForegroundTask.isRunningService) {
      return FlutterForegroundTask.restartService();
    } else {
      return FlutterForegroundTask.startService(
        serviceId: 256,
        notificationTitle: "Aplikacja działa w tle i monitoruje Twoją trasę",
        notificationText: "Dotknij, aby wrócić do aplikacji",
        notificationInitialRoute: "/",
        callback: startCallback,
      );
    }
  }

  static void initMyService() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: "foreground_service",
        channelName: "Foreground Service Notification",
        channelDescription: "This notification appears when the foreground service is running.",
        onlyAlertOnce: true,
      ),
      iosNotificationOptions: const IOSNotificationOptions(showNotification: false),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.nothing(),
        autoRunOnBoot: true,
        autoRunOnMyPackageReplaced: true,
        allowWifiLock: true,
      ),
    );
  }

  static Future<void> requestPermissions() async {
    final notificationPermission = await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermission != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }

    if (Platform.isAndroid) {
      if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
        await FlutterForegroundTask.requestIgnoreBatteryOptimization();
      }
      if (!await FlutterForegroundTask.canScheduleExactAlarms) {
        await FlutterForegroundTask.openAlarmsAndRemindersSettings();
      }
    }
  }
}
