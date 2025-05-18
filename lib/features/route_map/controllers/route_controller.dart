import "dart:async";
import "package:riverpod_annotation/riverpod_annotation.dart";

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
