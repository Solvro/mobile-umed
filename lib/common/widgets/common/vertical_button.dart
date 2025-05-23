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
      style: sharedCardButtonStyle(minimumHeight: VerticalButtonConfig.cardMinimumHeight),
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: VerticalButtonConfig.buttonInnerSpacing),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: VerticalButtonConfig.paddingHorizontal),
            child: Text(label, style: textStyle, textAlign: TextAlign.center),
          ),
          const Spacer(),
          Icon(icon, size: VerticalButtonConfig.iconSize, color: iconColor),
          const Spacer(),
        ],
      ),
    );
  }
}
