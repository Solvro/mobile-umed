import "package:flutter/material.dart" hide Route;
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
import "../../controllers/route_controller.dart";
import "../modals/landmark_info_modal.dart";
import "route_map_marker.dart";
import "route_map_polyline.dart";

class RouteMapWidget extends ConsumerStatefulWidget {
  const RouteMapWidget({super.key, required this.route, this.active = true});

  final Route route;

  final bool active;

  @override
  RouteMapWidgetState createState() => RouteMapWidgetState();
}

class RouteMapWidgetState extends ConsumerState<RouteMapWidget> {
  final mapController = MapController();

  void moveTo(LatLng latLng) {
    mapController.move(latLng, 15);
  }

  @override
  Widget build(BuildContext context) {
    final tileProvider = ref.watch(cacheTileProvider);

    final visitedCount = ref.watch(visitedCountProvider);
    final landmarks = widget.route.landmarks;
    final lineChangeIndex = calculateLineChangeFromLandmarksLatLng(
      landmarks: landmarks,
      route: widget.route.route,
      visited: visitedCount,
    );

    return switch (tileProvider) {
      AsyncData(:final value) =>
        landmarks.isEmpty
            ? FlutterMap(children: [TileLayer(urlTemplate: FlutterMapConfig.urlTemplate, maxZoom: 19)])
            : FlutterMap(
              options: MapOptions(initialCenter: landmarks.first.location),
              children: [
                TileLayer(urlTemplate: FlutterMapConfig.urlTemplate, tileProvider: value, maxZoom: 19),
                RouteMapPolyline(
                  locations: widget.route.route,
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
}
