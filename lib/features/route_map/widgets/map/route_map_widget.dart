import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "../../../../app/config/flutter_map_config.dart";
import "../../../../common/models/landmark.dart";

import "../landmark_info_modal.dart";
import "route_map_marker.dart";
import "route_map_polyline.dart";

class RouteMapWidget extends StatelessWidget {
  const RouteMapWidget({super.key, required this.landmarks});

  final IList<Landmark> landmarks;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(initialCenter: landmarks.first.location),
      children: [
        TileLayer(urlTemplate: FlutterMapConfig.urlTemplate, maxZoom: 19),
        RouteMapPolyline(
          locations: landmarks.map((landmark) => landmark.location).toList(),
          doneColor: Colors.green,
          notDoneColor: Colors.grey,
          visited: 3,
          active: false,
        ),
        MarkerLayer(
          markers:
              landmarks.asMap().entries.map((entry) {
                final int index = entry.key;
                final landmark = entry.value;
                return Marker(
                  point: landmark.location,
                  child: GestureDetector(
                    onTap: () async {
                      await showDialog<LandmarkInfoModal>(
                        context: context,
                        builder: (context) => LandmarkInfoModal(landmark: landmark),
                      );
                    },
                    child: RouteMapMarker(
                      type: landmark.type,
                      active: false,
                      start: index == 0,
                      finish: index == landmarks.length - 1,
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
