import "dart:math";
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
    required this.active,
  });
  final List<LatLng> locations;
  final Color doneColor;
  final Color notDoneColor;
  final Color inactiveColor;
  final int visited;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final divider = min(max(visited, 1), locations.length);
    final doneLocations = locations.sublist(0, divider);
    final notDoneLocations = locations.sublist(divider - 1);

    return PolylineLayer(
      polylines: [
        Polyline(
          points: doneLocations,
          color: active ? doneColor : inactiveColor,
          strokeWidth: MapConfig.visitedLineWidth,
        ),
        Polyline(
          points: notDoneLocations,
          color: active ? notDoneColor : inactiveColor,
          strokeWidth: MapConfig.unvisitedLineWidth,
          pattern: StrokePattern.dashed(segments: const [MapConfig.dashLen, MapConfig.spaceLen]),
        ),
      ],
    );
  }
}
