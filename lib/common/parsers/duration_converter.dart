import "package:freezed_annotation/freezed_annotation.dart";

class DurationMinutesConverter implements JsonConverter<Duration, double> {
  const DurationMinutesConverter();

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

class DurationSecondsConverter implements JsonConverter<Duration, int> {
  const DurationSecondsConverter();

  @override
  Duration fromJson(int json) => Duration(seconds: json);

  @override
  int toJson(Duration duration) => duration.inSeconds;
}
