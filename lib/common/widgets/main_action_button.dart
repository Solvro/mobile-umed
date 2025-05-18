import "package:flutter/material.dart";

import "../../app/config/ui_config.dart";

class MainActionButton extends StatelessWidget {
  const MainActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final chosenBgColor = backgroundColor ?? Theme.of(context).colorScheme.primary;
    final chosenTextColor = textColor ?? Theme.of(context).colorScheme.onPrimary;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(ButtonsConfig.minimumSize, ButtonsConfig.minimumSize),
          backgroundColor: chosenBgColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ButtonsConfig.mainActionButtonRadius)),
          padding: const EdgeInsets.symmetric(vertical: ButtonsConfig.mainActionButtonPadding),
        ),
        child: Text(text, style: TextStyle(color: chosenTextColor)),
      ),
    );
  }
}
