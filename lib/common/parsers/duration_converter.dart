import "package:freezed_annotation/freezed_annotation.dart";

class DurationConverter implements JsonConverter<Duration, double> {
  const DurationConverter();

  @override
  Duration fromJson(double json) {
    final int minutes = json.floor();
    final int seconds = ((json - minutes) * 60).round();
    return Duration(minutes: minutes, seconds: seconds);
  }

  @override
  double toJson(Duration duration) {
    return duration.inSeconds / 60.0;
  }
}
