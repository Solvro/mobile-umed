import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/theme/app_theme.dart";
import "../../../../common/models/landmark.dart";
import "route_progress_bar_icon.dart";
import "route_progress_bar_line.dart";

class RouteProgressBar extends StatefulWidget {
  final IList<Landmark> landmarks;
  final int visitedCount;

  const RouteProgressBar({super.key, required this.landmarks, required this.visitedCount});

  @override
  State<RouteProgressBar> createState() => _RouteProgressBarState();
}

class _RouteProgressBarState extends State<RouteProgressBar> {
  @override
  Widget build(BuildContext context) {
    final total = widget.landmarks.length;
    final visited = widget.visitedCount.clamp(0, total);

    return total <= 1
        ? const SizedBox()
        : Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: _decoration(context.colorScheme.surface),
            width: double.infinity,
            padding: const EdgeInsets.only(top: ProgressBarConfig.topPadding, bottom: ProgressBarConfig.bottomPadding),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: ProgressBarConfig.horizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.landmarks.length * 2 - 1, (i) {
                    if (i.isEven) {
                      final index = i ~/ 2;
                      final visited = index < widget.visitedCount;
                      if (index == 0) {
                        return RouteProgressBarIcon(start: true, done: true, color: context.colorScheme.primary);
                      }
                      if (index == total - 1) {
                        return RouteProgressBarIcon(finish: true, done: visited, color: context.colorScheme.primary);
                      }
                      return RouteProgressBarIcon(done: visited, color: context.colorScheme.primary);
                    } else {
                      final lineIndex = (i - 1) ~/ 2;
                      final isVisited = lineIndex < visited - 1;
                      return RouteProgressBarLine(color: context.colorScheme.primary, done: isVisited);
                    }
                  }),
                ),
              ),
            ),
          ),
        );
  }
}

BoxDecoration _decoration(Color color) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(ProgressBarConfig.radius),
    boxShadow: [BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 8, offset: const Offset(0, 2))],
  );
}
