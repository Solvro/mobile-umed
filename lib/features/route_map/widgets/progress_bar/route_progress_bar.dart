import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "../../../../common/models/landmark.dart";
import "route_progress_bar_icon.dart";
import "route_progress_bar_line.dart";

class RouteProgressBar extends StatefulWidget {
  final IList<Landmark> landmarks;
  final int visitedCount;
  final double progressBetweenLandmarks;
  static const Color barColor = Colors.green;

  const RouteProgressBar({
    super.key,
    required this.landmarks,
    required this.visitedCount,
    required this.progressBetweenLandmarks,
  });

  @override
  State<RouteProgressBar> createState() => _RouteProgressBarState();
}

class _RouteProgressBarState extends State<RouteProgressBar> {
  @override
  Widget build(BuildContext context) {
    final total = widget.landmarks.length;
    final visited = widget.visitedCount.clamp(0, total);
    final progress = widget.progressBetweenLandmarks.clamp(0.0, 1.0);

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        width: double.infinity,

        padding: const EdgeInsets.only(top: 4, bottom: 10),
        child: SafeArea(
          bottom: false,

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.landmarks.length * 2 - 1, (i) {
                if (i.isEven) {
                  final index = i ~/ 2;
                  final visited = index < widget.visitedCount;
                  if (index == 0) {
                    return const RouteProgressBarIcon(start: true, done: true, color: RouteProgressBar.barColor);
                  }
                  if (index == total - 1) {
                    return RouteProgressBarIcon(finish: true, done: visited, color: RouteProgressBar.barColor);
                  }
                  return RouteProgressBarIcon(done: visited, color: RouteProgressBar.barColor);
                } else {
                  final lineIndex = (i - 1) ~/ 2;
                  final isActiveLine = lineIndex == visited - 1;
                  final isVisited = lineIndex < visited - 1;
                  return RouteProgressBarLine(
                    color: RouteProgressBar.barColor,
                    done: isVisited,
                    active: isActiveLine,
                    percent: progress,
                  );
                }
              }),
            ),
          ),
        ),
      ),
    );
  }
}
