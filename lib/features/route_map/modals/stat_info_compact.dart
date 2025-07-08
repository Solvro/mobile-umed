import "package:flutter/material.dart";

import "../../../app/config/ui_config.dart";
import "../../../app/theme/app_theme.dart";

class StatInfoCompact extends StatelessWidget {
  const StatInfoCompact({super.key, required this.title, required this.value, required this.icon, required this.color});

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StatInfoCompactConfig.circleSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: StatInfoCompactConfig.boxLeftOffset,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(StatInfoCompactConfig.boxPadding),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: color, width: StatInfoCompactConfig.borderWidth),
                borderRadius: BorderRadius.circular(StatInfoCompactConfig.boxRad),
              ),
              child: Text(value, style: context.textTheme.bodyMedium),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: StatInfoCompactConfig.circleSize,
              width: StatInfoCompactConfig.circleSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colorScheme.surface,
                border: Border.all(color: color, width: StatInfoCompactConfig.borderWidth),
              ),
              padding: const EdgeInsets.all(StatInfoCompactConfig.iconPadding),
              child: Icon(icon, color: color),
            ),
          ),

          Positioned(top: 0, right: 0, child: Text(title, style: context.textTheme.bodySmall)),
        ],
      ),
    );
  }
}
