import "package:flutter/material.dart";
import "../../app/config/ui_config.dart";

class SecondaryActionButton extends StatelessWidget {
  const SecondaryActionButton({
    super.key,
    required this.onPressed,
    this.text,
    this.iconData,
    this.backgroundColor,
    this.textColor,
  });

  final String? text;
  final IconData? iconData;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final chosenBgColor = backgroundColor ?? Theme.of(context).colorScheme.primary;
    final chosenTextColor = textColor ?? Theme.of(context).colorScheme.onPrimary;
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ButtonsConfig.secondaryButtonShadowRadius),
          boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 2, spreadRadius: 1)],
        ),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: chosenBgColor,
            foregroundColor: chosenTextColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ButtonsConfig.secondaryButtonRadius)),
            padding: EdgeInsets.symmetric(vertical: iconData == null ? 2 : 1),
          ),
          child: _chooseButtonContent(iconData: iconData, text: text, textColor: chosenTextColor),
        ),
      ),
    );
  }
}

Widget _chooseButtonContent({IconData? iconData, String? text, Color? textColor}) {
  if (iconData == null && text == null) {
    return const SizedBox.shrink();
  } else if (iconData != null) {
    return Icon(iconData);
  } else {
    return Text(text!);
  }
}
