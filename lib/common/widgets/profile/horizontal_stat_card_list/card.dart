import "package:flutter/material.dart";

import "../../../../app/config/ui_config.dart";
import "../../../../app/theme/app_theme.dart";
import "../../../models/stats.dart";

class StatCard extends StatelessWidget {
  final Stats stat;
  final double width;
  final double height;
  final double iconSize;

  const StatCard({
    required this.stat,
    this.iconSize = CardListConfig.iconSize,
    this.width = CardListConfig.itemWidth,
    this.height = CardListConfig.height,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPaddings.small),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: context.colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(AppRadius.small),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1, offset: Offset(0, 3))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Opacity(
            opacity: StatCardConfig.iconOpacity,
            child: Icon(
              IconData(stat.iconCode, fontFamily: "MaterialIcons"),
              color: Color(stat.iconColor),
              size: iconSize,
            ),
          ),
          const Spacer(),
          Text(stat.value, style: context.textTheme.displayLarge),
        ],
      ),
    );
  }
}
