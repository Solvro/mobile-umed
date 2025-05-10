import "package:flutter/material.dart";

class MusicServiceButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const MusicServiceButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.green, width: 2),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      child: Icon(icon, color: Colors.green),
    );
  }
}
