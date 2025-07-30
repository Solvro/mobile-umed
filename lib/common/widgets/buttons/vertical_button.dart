import "package:flutter/material.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/theme/app_theme.dart";
import "../styling/button_styles.dart";

class VerticalButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onPressed;

  const VerticalButton({
    super.key,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: sharedCardButtonStyle(context,
          minimumHeight: VerticalButtonConfig.cardMinimumHeight,
          zeroPadding: true),
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: VerticalButtonConfig.greenHeader,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppRadius.small)),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: AppPaddings.small, vertical: AppPaddings.tinySmall),
            child: Text(label,
                style: context.textTheme.labelMedium,
                textAlign: TextAlign.center),
          ),
          const Spacer(),
          Icon(icon, size: VerticalButtonConfig.iconSize, color: iconColor),
          const Spacer(),
        ],
      ),
    );
  }
}
