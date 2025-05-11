import "package:flutter/material.dart";

class SecondaryActionButton extends StatelessWidget {
  const SecondaryActionButton({
    super.key,
    required this.onPressed,
    this.text,
    this.iconData,
    this.backgroundColor = Colors.green,
    this.textColor = Colors.white,
  });

  final String? text;
  final IconData? iconData;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 2, spreadRadius: 1)],
        ),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(44, 44),
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: EdgeInsets.symmetric(vertical: iconData == null ? 2 : 1),
          ),
          child: (iconData == null && text != null) ? Text(text!, style: TextStyle(color: textColor)) : Icon(iconData),
        ),
      ),
    );
  }
}
