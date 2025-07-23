import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "../../models/stats.dart";

final mockStats =
    [
      Stats(id: 1, value: "10.5 km", iconCode: Icons.directions_walk.codePoint, iconColor: Colors.green.toARGB32()),
      Stats(
        id: 2,
        value: "500 kcal",
        iconCode: Icons.local_fire_department.codePoint,
        iconColor: Colors.red.toARGB32(),
      ),
      Stats(id: 3, value: "2 L", iconCode: Icons.water_drop.codePoint, iconColor: Colors.blue.toARGB32()),
      Stats(id: 4, value: "3 h", iconCode: Icons.schedule.codePoint, iconColor: Colors.orange.toARGB32()),
    ].lock;

final mockAchievements =
    [
      Stats(id: 5, value: "Turysta", iconCode: Icons.local_see.codePoint, iconColor: Colors.black.toARGB32()),
      Stats(id: 6, value: "Sigma1", iconCode: Icons.man_3.codePoint, iconColor: Colors.black.toARGB32()),
    ].lock;
