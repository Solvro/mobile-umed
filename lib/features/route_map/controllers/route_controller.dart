import "dart:async";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:latlong2/latlong.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../common/models/landmark.dart";

part "route_controller.g.dart";

@riverpod
class Distance extends _$Distance {
  @override
  int build() {
    return 0;
  }

  void updateDistance(int distance) {
    state = distance;
  }

  void reset() {
    state = 0;
  }
}

@riverpod
class RouteTimer extends _$RouteTimer {
  Timer? _timer;

  @override
  Duration build() {
    ref.onDispose(() {
      _timer?.cancel();
      _timer = null;
    });

    return Duration.zero;
  }

  void start() {
    stop();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      state += const Duration(seconds: 1);
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void reset() {
    stop();
    state = Duration.zero;
  }
}

@riverpod
class Speed extends _$Speed {
  @override
  double build() {
    final distance = ref.watch(distanceProvider);
    final time = ref.watch(routeTimerProvider);

    if (time == Duration.zero) {
      return 0;
    }

    return (distance / time.inSeconds) * 3.6; // distance in km/h
  }
}

@riverpod
class VisitedCount extends _$VisitedCount {
  @override
  int build() {
    return 1;
  }

  void incrementVisited() {
    state = state + 1;
  }

  void resetVisited() {
    state = 1;
  }
}

bool latLngEqual(LatLng a, LatLng b, {double tolerance = 0.0003}) {
  return (a.latitude - b.latitude).abs() < tolerance && (a.longitude - b.longitude).abs() < tolerance;
}

int calculateLineChangeFromLandmarksLatLng({
  required IList<Landmark> landmarks,
  required IList<LatLng> route,
  required int visited,
}) {
  final index = visited.clamp(1, landmarks.length) - 1;
  final target = landmarks[index].location;
  return route.indexWhere((point) => latLngEqual(point, target)) + 1;
}
