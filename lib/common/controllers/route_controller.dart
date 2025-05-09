import "dart:async";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "route_controller.g.dart";

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
