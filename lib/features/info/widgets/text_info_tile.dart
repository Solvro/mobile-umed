import "package:flutter/material.dart";

import "../../../app/config/ui_config.dart";
import "../../../app/theme/app_theme.dart";

class TextInfoTile extends StatelessWidget {
  const TextInfoTile({super.key, this.title, required this.content, this.bottomActions});

  final String? title;
  final String content;
  final Widget? bottomActions;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(AppPaddings.tiny),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) Text(title!, style: context.textTheme.titleSmall),
            const SizedBox(height: AppPaddings.tinySmall),
            Text(content),
            const SizedBox(height: AppPaddings.small),
            if (bottomActions != null) Flexible(child: bottomActions!),
          ],
        ),
      ),
    );
  }
}
