import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";

import "../../../../app/config/flutter_map_config.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/theme/app_theme.dart";
import "../../../../common/models/landmark.dart";
import "../landmark_info_modal.dart";
import "route_map_marker.dart";
import "route_map_polyline.dart";

class RouteMapWidget extends StatelessWidget {
  const RouteMapWidget({super.key, required this.landmarks, required this.visitedCount, this.active = true});

  final IList<Landmark> landmarks;
  final int visitedCount;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(initialCenter: landmarks.first.location),
      children: [
        TileLayer(urlTemplate: FlutterMapConfig.urlTemplate, maxZoom: 19),
        RouteMapPolyline(
          locations: landmarks.map((landmark) => landmark.location).toList(),
          doneColor: context.colorScheme.primary,
          notDoneColor: Colors.grey,
          inactiveColor: Colors.grey,
          active: active,
          visited: visitedCount,
        ),
        MarkerLayer(
          markers:
              landmarks.asMap().entries.map((entry) {
                final int index = entry.key;
                final landmark = entry.value;
                return Marker(
                  alignment: Alignment.topCenter,
                  width: MapConfig.markerSize,
                  height: MapConfig.markerSize,
                  point: landmark.location,
                  rotate: true,
                  child: GestureDetector(
                    onTap: () async {
                      await showDialog<LandmarkInfoModal>(
                        context: context,
                        builder: (context) => LandmarkInfoModal(landmark: landmark),
                      );
                    },
                    child: RouteMapMarker(
                      type: landmark.type,
                      active: active,
                      start: index == 0,
                      finish: index == landmarks.length - 1,
                      visited: visitedCount - 1 >= index,
                      order: index,
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
