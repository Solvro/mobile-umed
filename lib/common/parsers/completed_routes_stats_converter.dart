import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "../../common/models/stats.dart";
import "../models/completed_route.dart";

IList<Stats> convertCompletedRoutesToStats(List<CompletedRoute> routes) {
  final double totalDistance = routes.fold(0, (sum, r) => sum + r.distance);
  final int totalCalories = routes.fold(0, (sum, r) => sum + r.calories);
  final int totalWaterMl = routes.fold(0, (sum, r) => sum + r.water);
  final double totalTimeMinutes = routes.fold(0, (sum, r) => sum + r.time);

  return [
    Stats(
      id: 1,
      value: "${totalDistance.toStringAsFixed(1)} km",
      iconCode: Icons.directions_walk.codePoint,
      iconColor: Colors.green.toARGB32(),
    ),
    Stats(
      id: 2,
      value: "$totalCalories kcal",
      iconCode: Icons.local_fire_department.codePoint,
      iconColor: Colors.red.toARGB32(),
    ),
    Stats(
      id: 3,
      value: "${(totalWaterMl / 1000).toStringAsFixed(1)} L",
      iconCode: Icons.water_drop.codePoint,
      iconColor: Colors.yellow.toARGB32(),
    ),
    Stats(
      id: 4,
      value: "${(totalTimeMinutes / 60).toStringAsFixed(1)} h",
      iconCode: Icons.schedule.codePoint,
      iconColor: Colors.orange.toARGB32(),
    ),
  ].lock;
}
