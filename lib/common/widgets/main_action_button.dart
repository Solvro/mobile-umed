import "package:flutter/material.dart";

class MainActionButton extends StatelessWidget {
  const MainActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.green,
    this.textColor = Colors.white,
  });

  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(44, 44),
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          padding: const EdgeInsets.symmetric(vertical: 6),
        ),
        child: Text(text, style: TextStyle(color: textColor)),
      ),
    );
  }
}
