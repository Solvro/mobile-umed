import "dart:async";
import "dart:io";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart" hide Route;
import "package:flutter_foreground_task/flutter_foreground_task.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_map_animations/flutter_map_animations.dart";
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
import "../../controllers/route_controller.dart" hide Distance;
import "../../modals/landmark_info_modal.dart";
import "../../modals/route_completed_modal.dart";
import "../../providers/locations_provider.dart";
import "../../providers/route_provider.dart";
import "../../services/flutter_foreground_task.dart";
import "../../services/task_handlers/route_background_task_handler.dart";
import "route_map_marker.dart";
import "route_map_polyline.dart";
import "route_selections_polyline.dart";

class RouteMapWidget extends ConsumerStatefulWidget {
  const RouteMapWidget({super.key, required this.controller, this.route, this.optionalRoutes, this.active = true});

  final AnimatedMapController controller;
  final Route? route;
  final IList<Route>? optionalRoutes;
  final bool active;

  @override
  RouteMapWidgetState createState() => RouteMapWidgetState();
}

class RouteMapWidgetState extends ConsumerState<RouteMapWidget> with WidgetsBindingObserver, TickerProviderStateMixin {
  Future<void> _onReceiveTaskData(Object data, WidgetRef ref) async {
    if (!mounted) {
      return;
    }
    if (data is String) {
      final event = TaskEvent.fromString(data);
      switch (event) {
        case TaskEvent.nextLocationReached:
          final locationIndex = ref.read(passedLocationsProvider);
          final nextLandmarkIndex = ref.read(visitedCountProvider);

          final distnaceInMeters = const Distance().as(
            LengthUnit.Meter,
            widget.route!.route[locationIndex],
            widget.route!.landmarks[nextLandmarkIndex].location,
          );
          if (distnaceInMeters <= LocalizationConfig.proximityThresholdInMeters) {
            ref.read(visitedCountProvider.notifier).incrementVisited();
          }

          ref.read(passedLocationsProvider.notifier).state++;
        case TaskEvent.routeCompleted:
          await showDialog<RouteCompletedModal>(context: context, builder: (context) => const RouteCompletedModal());
          await FlutterForegroundTask.stopService();
        case TaskEvent.error:
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $data")));
      }
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (Platform.isAndroid || Platform.isIOS) {
        await LocationService.requestPermissions();
        FlutterForegroundTask.addTaskDataCallback((data) async => _onReceiveTaskData(data, ref));
        await MyFlutterForegroundTask.requestPermissions();
        MyFlutterForegroundTask.initMyService();
        await MyFlutterForegroundTask.startMyForegroundService();
        if (widget.route != null) {
          FlutterForegroundTask.sendDataToTask(widget.route!.route.map((element) => element.toJson()).toList());
        }
      }
    });

    if (Platform.isIOS) {
      WidgetsBinding.instance.addObserver(this);
    }

    super.initState();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      await LocationService.requestPermissions();
    }
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final route = widget.route;
    final tileProvider = ref.watch(cacheTileProvider);
    final visitedCount = ref.watch(visitedCountProvider);
    final selectedProvider = ref.watch(selectedRouteProvider);
    final passedLocations = ref.watch(passedLocationsProvider);
    final landmarks = route?.landmarks ?? const IListConst([]);

    return switch (tileProvider) {
      AsyncData(:final value) =>
        route == null
            ? FlutterMap(
              options: const MapOptions(initialCenter: MapConfig.wroclawCenter),
              mapController: widget.controller.mapController,
              children: [
                TileLayer(urlTemplate: FlutterMapConfig.urlTemplate, maxZoom: 19),
                RouteSelectionsPolyline(
                  locations: (widget.optionalRoutes?.asList() ?? []).map((r) => r.route).toIList(),
                  selected: selectedProvider,
                  selectedColor: context.colorScheme.primary,
                  notSelectedColor: MapConfig.unvisitedColor,
                ),
              ],
            )
            : FlutterMap(
              mapController: widget.controller.mapController,
              options: MapOptions(initialCenter: landmarks.first.location),
              children: [
                TileLayer(urlTemplate: FlutterMapConfig.urlTemplate, tileProvider: value, maxZoom: 19),
                RouteMapPolyline(
                  locations: route.route,
                  doneColor: context.colorScheme.primary,
                  notDoneColor: MapConfig.unvisitedColor,
                  inactiveColor: MapConfig.inactiveColor,
                  active: widget.active,
                  passedLocations: passedLocations,
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
                        final Alignment alignment =
                            index == 0
                                ? Alignment.center
                                : index == landmarks.length - 1
                                ? Alignment.topRight
                                : Alignment.topCenter;
                        return _buildMarkers(
                          context: context,
                          landmark: landmark,
                          index: index,
                          visitedCount: visitedCount,
                          active: widget.active,
                          totalLandmarks: landmarks.length,
                          markerAlignment: alignment,
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
      key: ValueKey("marker_${landmark.id}_$visitedCount"),
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
                  builder: (_) => LandmarkInfoModal(landmark: landmark),
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
