import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "../extensions/double_ext.dart";
import "../extensions/int_ext.dart";
import "../models/completed_route.dart";
import "../models/stat.dart";

IList<Stat> convertCompletedRoutesToStats(List<CompletedRoute> routes) {
  final double totalDistance = routes.fold(0, (sum, r) => sum + r.distance);
  final int totalCalories = routes.fold(0, (sum, r) => sum + r.calories);
  final int totalWaterMl = routes.fold(0, (sum, r) => sum + r.water);
  final int totalTimeMinutes = routes.fold(0, (sum, r) => sum + r.time);

  return [
    Stat(
      id: 1,
      value: totalDistance.inKilometers(),
      iconData: Icons.directions_walk,
      iconColor: Colors.green.toARGB32(),
    ),
    Stat(id: 2, value: totalCalories.inKcal(), iconData: Icons.local_fire_department, iconColor: Colors.red.toARGB32()),
    Stat(id: 3, value: totalWaterMl.inLiters(), iconData: Icons.water_drop, iconColor: Colors.yellow.toARGB32()),
    Stat(id: 4, value: totalTimeMinutes.inHours(), iconData: Icons.schedule, iconColor: Colors.orange.toARGB32()),
  ].lock;
}
