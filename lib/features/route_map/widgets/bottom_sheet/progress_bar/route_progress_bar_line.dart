import "package:flutter/material.dart" hide Route;
import "../../../../../app/config/ui_config.dart";

class RouteProgressBarLine extends StatelessWidget {
  const RouteProgressBarLine({super.key, required this.color, required this.done});
  final Color color;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: ProgressBarConfig.lineHeight,
            margin: const EdgeInsets.symmetric(horizontal: ProgressBarConfig.dotLinePadding),
            decoration: BoxDecoration(
              color: done ? color : color.withAlpha(ProgressBarConfig.notDoneAlpha),
              borderRadius: BorderRadius.circular(ProgressBarConfig.lineHeight),
            ),
          );
        },
      ),
    );
  }
}
