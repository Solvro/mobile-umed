import "package:flutter/material.dart";

import "../../../app/assets/assets.gen.dart";
import "../../../app/config/ui_config.dart";
import "../../../app/theme/app_theme.dart";

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Assets.icons.sectionTitleDecoration.svg(
          width: InfoSectionConfig.sectionTitleDecorationSize,
          height: InfoSectionConfig.sectionTitleDecorationSize,
        ),
        const SizedBox(width: AppPaddings.tiny),
        Text(title, style: context.textTheme.headlineSmall),
      ],
    );
  }
}
