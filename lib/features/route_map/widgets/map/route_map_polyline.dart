import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart" hide Route;
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "../../../../app/config/ui_config.dart";

class RouteMapPolyline extends StatelessWidget {
  const RouteMapPolyline({
    super.key,
    required this.locations,
    required this.doneColor,
    required this.notDoneColor,
    required this.inactiveColor,
    required this.visited,
    required this.passedLocations,
    required this.active,
  });
  final IList<LatLng> locations;
  final Color doneColor;
  final Color notDoneColor;
  final Color inactiveColor;
  final int visited;
  final int passedLocations;
  final bool active;

  @override
  Widget build(BuildContext context) {
    if (locations.isEmpty) return PolylineLayer(polylines: [Polyline(points: [])]);
    // final divider = visited.clamp(1, locations.length);
    // final doneLocations = locations.sublist(0, divider);
    // final notDoneLocations = locations.sublist(divider - 1);

    final doneLocations = locations.sublist(0, passedLocations + 1);
    final notDoneLocations = locations.sublist(passedLocations);

    return PolylineLayer(
      polylines: [
        Polyline(
          points: doneLocations.toList(),
          color: active ? doneColor : inactiveColor,
          strokeWidth: MapConfig.visitedLineWidth,
        ),
        Polyline(
          points: notDoneLocations.toList(),
          color: active ? notDoneColor : inactiveColor,
          strokeWidth: MapConfig.unvisitedLineWidth,
          pattern: StrokePattern.dashed(segments: const [MapConfig.dashLen, MapConfig.spaceLen]),
        ),
      ],
    );
  }
}
