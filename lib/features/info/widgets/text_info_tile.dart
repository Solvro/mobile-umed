import "package:flutter/material.dart";

import "../../../app/config/ui_config.dart";
import "../../../app/theme/app_theme.dart";

class TextInfoTile extends StatelessWidget {
  const TextInfoTile({super.key, required this.title, required this.content, required this.bottomActions});

  final String title;
  final String content;
  final Widget bottomActions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppPaddings.medium,
        top: AppPaddings.tiny,
        left: AppPaddings.medium,
        right: AppPaddings.medium,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppPaddings.tiny),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(InfoSectionConfig.radius), // Rounded corners
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 5, offset: const Offset(0, 4))],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.textTheme.titleSmall),
            const SizedBox(height: AppPaddings.tinySmall),
            Text(content),
            const SizedBox(height: AppPaddings.small),
            Flexible(child: bottomActions),
          ],
        ),
      ),
    );
  }
}
