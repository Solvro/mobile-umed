import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../../common/parsers/duration_converter.dart";

part "foreground_task_protocol.freezed.dart";
part "foreground_task_protocol.g.dart";

@freezed
abstract class ForegroundTaskProtocol with _$ForegroundTaskProtocol {
  const factory ForegroundTaskProtocol({
    @DurationSecondsConverter() Duration? elapsed,
    int? distance,
    TaskEvent? event,
  }) = _ForegroundTaskProtocol;

  factory ForegroundTaskProtocol.onlyDurationStats(Duration elapsed, int distance) =>
      ForegroundTaskProtocol(elapsed: elapsed, distance: distance);
  factory ForegroundTaskProtocol.onlyEvent(TaskEvent event) => ForegroundTaskProtocol(event: event);

  factory ForegroundTaskProtocol.fromJson(Map<String, dynamic> json) => _$ForegroundTaskProtocolFromJson(json);

  const ForegroundTaskProtocol._();

  bool get isStats => elapsed != null && distance != null;
  bool get isEvent => event != null;
}

enum TaskEvent { nextLocationReached, nextCheckpointReached, routeCompleted, error }
