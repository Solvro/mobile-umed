import "package:flutter/material.dart";

/// Section header with left accent stripe
class SectionAccent extends StatelessWidget {
  final double width;
  final double height;

  /// Accent color
  final Color color;

  const SectionAccent({super.key, this.width = 24, this.height = 28, this.color = Colors.lightGreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
    );
  }
}
