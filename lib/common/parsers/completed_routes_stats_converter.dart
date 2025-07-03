import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "../../common/models/stats.dart";
import "../models/completed_route.dart";
import "../models/route.dart";

IList<Stats> convertCompletedRoutesToStats(List<CompletedRoute> routes) {
  final double totalDistance = routes.fold(0, (sum, r) => sum + r.distance);
  final int totalCalories = routes.fold(0, (sum, r) => sum + r.calories);
  final int totalWaterMl = routes.fold(0, (sum, r) => sum + r.water);
  final int totalTimeMinutes = routes.fold(0, (sum, r) => sum + r.time);

  return [
    Stats(
      id: 1,
      value: totalDistance.inKilometers(),
      iconCode: Icons.directions_walk.codePoint,
      iconColor: Colors.green.toARGB32(),
    ),
    Stats(
      id: 2,
      value: totalCalories.inKcal(),
      iconCode: Icons.local_fire_department.codePoint,
      iconColor: Colors.red.toARGB32(),
    ),
    Stats(
      id: 3,
      value: totalWaterMl.inLiters(),
      iconCode: Icons.water_drop.codePoint,
      iconColor: Colors.yellow.toARGB32(),
    ),
    Stats(
      id: 4,
      value: totalTimeMinutes.inHours(),
      iconCode: Icons.schedule.codePoint,
      iconColor: Colors.orange.toARGB32(),
    ),
  ].lock;
}
