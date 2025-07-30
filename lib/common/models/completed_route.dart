import "package:freezed_annotation/freezed_annotation.dart";

part "completed_route.freezed.dart";
part "completed_route.g.dart";

@freezed
abstract class CompletedRoute with _$CompletedRoute {
  const factory CompletedRoute({
    required DateTime dateCompleted,
    required int routeId,
    required int water,
    required double distance,
    required int calories,
    required int time,
  }) = _CompletedRoute;

  factory CompletedRoute.fromJson(Map<String, dynamic> json) =>
      _$CompletedRouteFromJson(json);
}
