import "package:flutter/material.dart";
import "../../../../../app/config/ui_config.dart";
import "../../../../app/theme/app_theme.dart";

class SectionAccent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SectionAccentConfig.width,
      height: SectionAccentConfig.height,
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: const BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
    );
  }
}
