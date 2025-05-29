import "package:flutter/material.dart";
import "../../../../app/config/ui_config.dart";
import "button_styles.dart";

class VerticalButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onPressed;
  final TextStyle textStyle;

  const VerticalButton({
    super.key,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.onPressed,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: sharedCardButtonStyle(minimumHeight: VerticalButtonConfig.cardMinimumHeight, zeroPadding: true),
      onPressed: onPressed,

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.greenColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(VerticalButtonConfig.containerRadius)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: AppPaddings.small, vertical: AppPaddings.tinySmall),
            child: Text(label, style: textStyle.copyWith(color: AppColors.white), textAlign: TextAlign.center),
          ),
          const Spacer(),
          Icon(icon, size: VerticalButtonConfig.iconSize, color: iconColor),
          const Spacer(),
        ],
      ),
    );
  }
}
