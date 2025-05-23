import "package:flutter/material.dart";
import "section_accent.dart";

/// Mały widget z zaokrąglonym paskiem po lewej stronie
class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16), // dodany margines 16 pod nagłówkiem
      child: Row(
        children: [
          const SectionAccent(),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
