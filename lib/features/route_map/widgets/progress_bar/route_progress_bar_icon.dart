import "package:flutter/material.dart" hide Route;
import "../../../../app/config/ui_config.dart";

class RouteProgressBarIcon extends StatelessWidget {
  const RouteProgressBarIcon({
    super.key,
    required this.color,
    required this.done,
    this.start = false,
    this.finish = false,
  });
  final Color color;
  final bool done;
  final bool start;
  final bool finish;

  @override
  Widget build(BuildContext context) {
    if (start) {
      return Icon(Icons.play_circle_fill, color: color);
    }
    if (finish) {
      return Icon(Icons.flag_circle, color: done ? color : color.withAlpha(ProgressBarConfig.notDoneAlpha));
    }

    return done
        ? Icon(Icons.check_circle, color: color)
        : Icon(Icons.radio_button_unchecked, color: color.withAlpha(ProgressBarConfig.notDoneAlpha));
  }
}
