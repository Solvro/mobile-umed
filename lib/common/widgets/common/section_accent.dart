import "package:flutter/material.dart";
import "../../../../../app/config/ui_config.dart";

class SectionAccent extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const SectionAccent({super.key, this.width = 24, this.height = 28, this.color = AppColors.greenColor});

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
