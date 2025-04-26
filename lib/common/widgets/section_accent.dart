import "package:flutter/material.dart";

/// Mały widget z zaokrąglonym paskiem po lewej stronie
class SectionAccent extends StatelessWidget {
  /// Szerokość paska
  final double width;

  /// Wysokość paska
  final double height;

  /// Kolor paska
  final Color color;

  const SectionAccent({Key? key, this.width = 24, this.height = 28, this.color = Colors.lightGreen}) : super(key: key);

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
