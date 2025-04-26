import "package:flutter/material.dart";
import "./section_accent.dart";

/// Mały widget z zaokrąglonym paskiem po lewej stronie
class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) => Row(
    children: [const SectionAccent(), const SizedBox(width: 8), Text(title, style: const TextStyle(fontSize: 20))],
  );
}
