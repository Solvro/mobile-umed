import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "../../widgets/profile/horizontal_stat_card_list/card.dart";

final IList<StatCard> mockStats =
    [
      StatCard(value: "10.5 km", iconCode: Icons.directions_walk.codePoint, iconColor: Colors.green.toARGB32()),
      StatCard(value: "500 kcal", iconCode: Icons.local_fire_department.codePoint, iconColor: Colors.red.toARGB32()),
      StatCard(value: "2 L", iconCode: Icons.water_drop.codePoint, iconColor: Colors.blue.toARGB32()),
      StatCard(value: "3 h", iconCode: Icons.schedule.codePoint, iconColor: Colors.orange.toARGB32()),
    ].lock;

final IList<StatCard> mockAchievements =
    [
      StatCard(value: "Turysta", iconCode: Icons.local_see.codePoint, iconColor: Colors.black.toARGB32()),
      StatCard(value: "Sigma", iconCode: Icons.man_3.codePoint, iconColor: Colors.black.toARGB32()),
    ].lock;
