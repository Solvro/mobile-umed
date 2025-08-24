import "package:freezed_annotation/freezed_annotation.dart";

import "../../features/map/route_map/services/task_handlers/foreground_task_protocol.dart";
import "../parsers/duration_converter.dart";

part "route_stats.freezed.dart";
part "route_stats.g.dart";

@freezed
abstract class RouteStatsModel with _$RouteStatsModel {
  const factory RouteStatsModel({@DurationSecondsConverter() required Duration elapsed, required int distance}) =
      _RouteStatsModel;

  factory RouteStatsModel.fromProtocol(ForegroundTaskProtocol protocol) {
    if (!protocol.isStats) {
      throw ArgumentError("Protocol does not contain stats");
    }
    return RouteStatsModel(elapsed: protocol.elapsed!, distance: protocol.distance!);
  }

  const RouteStatsModel._();

  factory RouteStatsModel.fromJson(Map<String, dynamic> json) => _$RouteStatsModelFromJson(json);
}
