import "package:flutter/material.dart";

import "../../app/config/ui_config.dart";
import "../../app/theme/app_theme.dart";

class ListLabel extends StatelessWidget {
  const ListLabel({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Container(
            height: BottomSheetConfig.itemDotRadius,
            width: BottomSheetConfig.itemDotRadius,
            decoration: BoxDecoration(shape: BoxShape.circle, color: context.colorScheme.primary),
            alignment: Alignment.center,
            child: Text(index.toString(), style: TextStyle(color: context.colorScheme.onPrimary)),
          ),
        ),
        Container(height: BottomSheetConfig.itemDotRadius, width: 4, color: context.colorScheme.primary),
        const SizedBox(height: 1),
      ],
    );
  }
}
