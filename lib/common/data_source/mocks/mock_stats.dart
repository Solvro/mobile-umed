import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "../../../../app/config/ui_config.dart";
import "../../widgets/profile/horizontal_stat_card_list/stat_card.dart";

final IList<StatCard> mockStats =
    [
      const StatCard(
        value: "10.5 km",
        icon: Icon(Icons.directions_walk, color: Colors.green, size: StatListConfig.iconSize),
      ),
      const StatCard(
        value: "500 kcal",
        icon: Icon(Icons.local_fire_department, color: Colors.red, size: StatListConfig.iconSize),
      ),
      const StatCard(value: "2 L", icon: Icon(Icons.water_drop, color: Colors.blue, size: StatListConfig.iconSize)),
      const StatCard(value: "3 h", icon: Icon(Icons.schedule, color: Colors.orange, size: StatListConfig.iconSize)),
    ].lock;
