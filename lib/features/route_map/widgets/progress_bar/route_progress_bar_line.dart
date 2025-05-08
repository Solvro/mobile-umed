import "package:flutter/material.dart" hide Route;

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
  int get notDoneAlpha => 50;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          const padding = 2.0;
          const dotRad = 4.0;
          const lineHeight = 2.0;
          final lineWidth = constraints.maxWidth - padding - dotRad;

          final dotOffset = lineWidth * percent;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: lineHeight,
                margin: const EdgeInsets.symmetric(horizontal: padding),
                decoration: BoxDecoration(
                  color: done ? color : color.withAlpha(notDoneAlpha),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              if (active)
                Positioned(
                  left: 0,
                  right: lineWidth - dotOffset,
                  child: Container(
                    height: lineHeight,
                    margin: const EdgeInsets.symmetric(horizontal: padding),
                    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(lineHeight)),
                  ),
                ),
              if (active)
                Positioned(
                  left: dotOffset,
                  top: -dotRad + 1,
                  child: Container(
                    width: dotRad * 2,
                    height: dotRad * 2,
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
