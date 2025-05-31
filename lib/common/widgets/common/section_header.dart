import "package:flutter/material.dart";
import "../../../../../app/config/ui_config.dart";
import "../../../app/theme/app_theme.dart";
import "section_accent.dart";

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppPaddings.small),
      child: Row(
        children: [
          SectionAccent(),
          const SizedBox(width: AppPaddings.tiny),
          Text(title, style: context.textTheme.headlineLarge),
        ],
      ),
    );
  }
}
