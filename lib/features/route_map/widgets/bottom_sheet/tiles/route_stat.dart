import "package:flutter/widgets.dart";

import "../../../../../app/theme/app_theme.dart";

class RouteStat extends StatelessWidget {
  const RouteStat({super.key, required this.imgPath, required this.comment});

  final String imgPath;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: Column(
        children: [
          Image.asset(imgPath, height: 20, width: 20),
          const SizedBox(height: 2),
          Text(comment, style: context.textTheme.bodySmall?.copyWith(fontSize: 10)),
        ],
      ),
    );
  }
}
