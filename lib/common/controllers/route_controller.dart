import "dart:async";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "route_controller.g.dart";

@riverpod
class Distance extends _$Distance {
  int _distance = 0; // Distance in meters

  @override
  int build() {
    return _distance;
  }

  void updateDistance(int distance) {
    _distance = distance;
    state = _distance;
  }

  void reset() {
    _distance = 0;
    state = _distance;
  }
}

@riverpod
class RouteTimer extends _$RouteTimer {
  Timer? _timer;

  @override
  Duration build() {
    return Duration.zero;
  }

  void start() {
    _timer ??= Timer.periodic(const Duration(seconds: 1), (_) {
      state = state + const Duration(seconds: 1);
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

  Duration get current => state;

  void dispose() {
    _timer?.cancel();
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
