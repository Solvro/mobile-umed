import "package:flutter/material.dart";

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
          minimumSize: const Size(44, 44),
          backgroundColor: chosenBgColor,
          foregroundColor: chosenTextColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          padding: const EdgeInsets.symmetric(vertical: 6),
        ),
        child: Text(text, style: TextStyle(color: chosenTextColor)),
      ),
    );
  }
}
