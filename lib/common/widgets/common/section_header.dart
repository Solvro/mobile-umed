import "package:flutter/material.dart";
import "../../../../../app/config/ui_config.dart";
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
          const SectionAccent(),
          const SizedBox(width: AppPaddings.tiny),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
