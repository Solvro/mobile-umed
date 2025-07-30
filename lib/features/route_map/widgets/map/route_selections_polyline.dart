import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart" hide Route;
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../common/models/route.dart";

class RouteSelectionsPolyline extends StatelessWidget {
  const RouteSelectionsPolyline({
    super.key,
    required this.locations,
    this.lastInteracted,
    required this.selectedColor,
    required this.notSelectedColor,
  });
  final IList<IList<LatLng>> locations;
  final Route? lastInteracted;
  final Color selectedColor;
  final Color notSelectedColor;

  @override
  Widget build(BuildContext context) {
    if (locations.isEmpty)
      return PolylineLayer(polylines: [Polyline(points: [])]);

    return PolylineLayer(
      polylines: [
        ...locations.map(
          (element) => Polyline(
              points: element.toList(),
              color: notSelectedColor,
              strokeWidth: MapConfig.unvisitedLineWidth),
        ),
        if (lastInteracted != null)
          Polyline(
            points: lastInteracted!.route.toList(),
            color: selectedColor,
            strokeWidth: MapConfig.visitedLineWidth,
          ),
      ],
    );
  }
}
