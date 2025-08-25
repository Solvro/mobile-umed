import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:latlong2/latlong.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../common/models/checkpoint.dart";

part "route_controller.g.dart";

@Riverpod(dependencies: [])
class VisitedCount extends _$VisitedCount {
  @override
  int build() {
    return 0;
  }

  void incrementVisited() {
    state = state + 1;
  }

  void resetVisited() {
    state = 0;
  }
}

bool latLngEqual(LatLng a, LatLng b, {double tolerance = 0.0003}) {
  return (a.latitude - b.latitude).abs() < tolerance && (a.longitude - b.longitude).abs() < tolerance;
}

int calculateLineChangeFromLandmarksLatLng({
  required IList<Checkpoint> checkpoints,
  required IList<LatLng> route,
  required int visited,
}) {
  if (checkpoints.isEmpty) {
    return 0;
  }

  final index = visited.clamp(1, checkpoints.length) - 1;
  final target = checkpoints[index].location;
  return route.indexWhere((point) => latLngEqual(point, target)) + 1;
}
