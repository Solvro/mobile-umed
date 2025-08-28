import "package:flutter/material.dart";

import "../../../../app/config/ui_config.dart";
import "../../../../app/theme/app_theme.dart";
import "../../../../common/models/stat.dart";

class StatCard extends StatelessWidget {
  final Stat stat;
  final double width;
  final double height;
  final double iconSize;
  final bool isValueText;

  const StatCard({
    required this.stat,
    this.iconSize = CardListConfig.iconSize,
    this.width = CardListConfig.itemWidth,
    this.height = CardListConfig.height,
    this.isValueText = false,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: context.colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(AppRadius.small),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1, offset: Offset(0, 3))],
      ),
      child: Container(
        padding: const EdgeInsets.all(AppPaddings.small),
        height: height,
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Opacity(
              opacity: StatCardConfig.iconOpacity,
              child: Icon(stat.iconData, color: Color(stat.iconColor), size: iconSize),
            ),
            Text(stat.value, style: isValueText ? context.textTheme.headlineSmall : context.textTheme.displayLarge),
          ],
        ),
      ),
    );
  }
}
