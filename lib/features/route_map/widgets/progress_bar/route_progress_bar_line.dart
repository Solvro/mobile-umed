import "package:flutter/material.dart" hide Route;
import "../../../../app/config/ui_config.dart";

class RouteProgressBarLine extends StatelessWidget {
  const RouteProgressBarLine({
    super.key,
    required this.color,
    required this.done,
    this.active = false,
    this.percent = 0.5,
  });
  final Color color;
  final bool done;
  final bool active;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final lineWidth = constraints.maxWidth - ProgressBarConfig.dotLinePadding - ProgressBarConfig.dotRad;

          final dotOffset = lineWidth * percent;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: ProgressBarConfig.lineHeight,
                margin: const EdgeInsets.symmetric(horizontal: ProgressBarConfig.dotLinePadding),
                decoration: BoxDecoration(
                  color: done ? color : color.withAlpha(ProgressBarConfig.notDoneAlpha),
                  borderRadius: BorderRadius.circular(ProgressBarConfig.lineHeight),
                ),
              ),

              if (active)
                Positioned(
                  left: 0,
                  right: lineWidth - dotOffset,
                  child: Container(
                    height: ProgressBarConfig.lineHeight,
                    margin: const EdgeInsets.symmetric(horizontal: ProgressBarConfig.dotLinePadding),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(ProgressBarConfig.lineHeight),
                    ),
                  ),
                ),
              if (active)
                Positioned(
                  left: dotOffset,
                  top: -ProgressBarConfig.dotRad + 1,
                  child: Container(
                    width: ProgressBarConfig.dotRad * 2,
                    height: ProgressBarConfig.dotRad * 2,
                    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
