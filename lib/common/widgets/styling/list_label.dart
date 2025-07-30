import "package:flutter/material.dart";
import "../../../app/config/ui_config.dart";
import "../../../app/theme/app_theme.dart";

class ListLabel extends StatelessWidget {
  const ListLabel({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: AppPaddings.nano,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Container(
            height: AppRadius.big,
            width: AppRadius.big,
            decoration: BoxDecoration(shape: BoxShape.circle, color: context.colorScheme.primary),
            alignment: Alignment.center,
            child: Text(index.toString(), style: TextStyle(color: context.colorScheme.onPrimary)),
          ),
        ),
        Container(height: AppRadius.big, width: 4, color: context.colorScheme.primary),
        const SizedBox(height: 1),
      ],
    );
  }
}
