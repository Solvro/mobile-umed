import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_map_tile_caching/flutter_map_tile_caching.dart";

import "../../../../app/config/flutter_map_config.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/theme/app_theme.dart";
import "../../../../common/models/landmark.dart";
import "../modals/landmark_info_modal.dart";
import "route_map_marker.dart";
import "route_map_polyline.dart";

class RouteMapWidget extends StatelessWidget {
  RouteMapWidget({super.key, required this.landmarks, required this.visitedCount, this.active = true});
  final _tileProvider = FMTCTileProvider(stores: const {"mapStore": BrowseStoreStrategy.readUpdateCreate});

  final IList<Landmark> landmarks;
  final int visitedCount;
  final bool active;

  @override
  Widget build(BuildContext context) {
    if (landmarks.isEmpty) {
      return FlutterMap(
        children: [TileLayer(urlTemplate: FlutterMapConfig.urlTemplate, tileProvider: _tileProvider, maxZoom: 19)],
      );
    }
    return FlutterMap(
      options: MapOptions(initialCenter: landmarks.first.location),
      children: [
        TileLayer(urlTemplate: FlutterMapConfig.urlTemplate, tileProvider: _tileProvider, maxZoom: 19),
        RouteMapPolyline(
          locations: landmarks.map((landmark) => landmark.location).toList(),
          doneColor: context.colorScheme.primary,
          notDoneColor: MapConfig.unvisitedColor,
          inactiveColor: MapConfig.inactiveColor,
          active: active,
          visited: visitedCount,
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
                  active: active,
                  totalLandmarks: landmarks.length,
                  markerAlignment: alignment ?? Alignment.topCenter,
                );
              }).toList(),
        ),
      ],
    );
  }
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
              ? () async {
                await showDialog<LandmarkInfoModal>(
                  context: context,
                  builder: (context) => LandmarkInfoModal(landmark: landmark),
                );
              }
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
