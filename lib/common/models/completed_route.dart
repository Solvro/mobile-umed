import "package:freezed_annotation/freezed_annotation.dart";

import "route.dart";

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

  factory CompletedRoute.fromJson(Map<String, dynamic> json) => _$CompletedRouteFromJson(json);

  const CompletedRoute._();

  factory CompletedRoute.fromRoute(Route route) {
    return CompletedRoute(
      dateCompleted: DateTime.now(),
      routeId: route.id,
      water: route.waterDemand?.toInt() ?? 0,
      distance: route.distance,
      calories: route.calories ?? 0,
      time: route.estimatedTime ?? 0,
    );
  }
}
