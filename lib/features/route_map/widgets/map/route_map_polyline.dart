import "dart:math";
import "package:flutter/material.dart" hide Route;
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";

class RouteMapPolyline extends StatelessWidget {
  const RouteMapPolyline({
    super.key,
    required this.locations,
    required this.doneColor,
    required this.notDoneColor,
    required this.visited,
    required this.active,
  });
  final List<LatLng> locations;
  final Color doneColor;
  final Color notDoneColor;
  final int visited;
  final bool active;

  @override
  Widget build(BuildContext context) {
    const inactiveColor = Colors.red;
    final divider = max(visited, 1);
    final doneLocations = locations.sublist(0, divider);
    final notDoneLocations = locations.sublist(divider - 1);

    return PolylineLayer(
      polylines: [
        Polyline(points: doneLocations, color: active ? doneColor : inactiveColor, strokeWidth: 4),
        Polyline(
          points: notDoneLocations,
          color: active ? notDoneColor : inactiveColor,
          strokeWidth: 4,
          pattern: StrokePattern.dashed(segments: const [5.0, 4.0]),
        ),
      ],
    );
  }
}
