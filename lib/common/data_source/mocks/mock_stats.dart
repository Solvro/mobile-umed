import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "../../models/stats.dart";

final mockStats =
    [
      Stats(id: 1, value: "10.5 km", iconData: Icons.directions_walk, iconColor: Colors.green.toARGB32()),
      Stats(id: 2, value: "500 kcal", iconData: Icons.local_fire_department, iconColor: Colors.red.toARGB32()),
      Stats(id: 3, value: "2 L", iconData: Icons.water_drop, iconColor: Colors.blue.toARGB32()),
      Stats(id: 4, value: "3 h", iconData: Icons.schedule, iconColor: Colors.orange.toARGB32()),
    ].lock;

final mockAchievements =
    [
      Stats(id: 5, value: "Turysta", iconData: Icons.local_see, iconColor: Colors.black.toARGB32()),
      Stats(id: 6, value: "Sigma", iconData: Icons.man_3, iconColor: Colors.black.toARGB32()),
    ].lock;
