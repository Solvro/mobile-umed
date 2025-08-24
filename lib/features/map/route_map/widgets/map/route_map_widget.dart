import "dart:async";
import "dart:io";
import "package:flutter/material.dart" hide Route;
import "package:flutter_map/flutter_map.dart";
import "package:flutter_map_animations/flutter_map_animations.dart";
import "package:flutter_map_location_marker/flutter_map_location_marker.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../../../app/config/flutter_map_config.dart";
import "../../../../../app/config/ui_config.dart";
import "../../../../../app/theme/app_theme.dart";
import "../../../../../common/models/checkpoint.dart";
import "../../../../../common/models/route.dart";
import "../../../../../common/providers/cache_tile.dart";
import "../../../../../common/utils/location_service.dart";
import "../../controllers/route_controller.dart" hide Distance;
import "../../modals/landmark_info_modal.dart";
import "../../providers/locations_provider.dart";
import "route_map_marker.dart";
import "route_map_polyline.dart";

class RouteMapWidget extends ConsumerStatefulWidget {
  const RouteMapWidget({super.key, required this.controller, required this.route, this.active = true});

  final AnimatedMapController controller;
  final Route route;
  final bool active;

  @override
  RouteMapWidgetState createState() => RouteMapWidgetState();
}

class RouteMapWidgetState extends ConsumerState<RouteMapWidget> with WidgetsBindingObserver, TickerProviderStateMixin {
  @override
  void initState() {
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
  Widget build(BuildContext context) {
    final route = widget.route;
    final tileProvider = ref.watch(cacheTileProvider);
    final visitedCount = ref.watch(visitedCountProvider);
    final passedLocations = ref.watch(passedLocationsProvider);
    final landmarks = route.checkpoints;

    return switch (tileProvider) {
      AsyncData(:final value) => FlutterMap(
        mapController: widget.controller.mapController,
        options: MapOptions(initialCenter: landmarks.isNotEmpty ? landmarks.first.location : route.route.first),
        children: [
          TileLayer(urlTemplate: FlutterMapConfig.urlTemplate, tileProvider: value, maxZoom: MapConfig.maxZoom),
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
    required Checkpoint landmark,
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
                  builder: (_) => LandmarkInfoModal(checkpoint: landmark),
                )
                : null,
        child: RouteMapMarker(type: landmark.type, active: active, visited: visitedCount > index, order: index),
      ),
    );
  }
}
