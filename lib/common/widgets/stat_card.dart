import "package:flutter/material.dart";

/// A white, rounded stat card with customizable size, responsive layout,
/// and optional tap action.
class StatCard extends StatelessWidget {
  /// Primary number or statistic to display, e.g. "1200" or "5.2"
  final String value;

  /// Unit or label describing the statistic, e.g. "kcal" or "km"
  final String label;

  /// Optional fixed width of the card.
  final double? width;

  /// Optional fixed height of the card.
  final double? height;

  /// Optional tap callback.
  final VoidCallback? onTap;

  const StatCard({super.key, required this.value, required this.label, this.width, this.height, this.onTap});

  @override
  @override
  Widget build(BuildContext context) {
    // 1. Inside of the Card: Container with padding, decoration and Column of text
    Widget card = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1, offset: Offset(0, 3))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
          const Spacer(),
          Text(label, style: const TextStyle(fontSize: 20, color: Colors.black)),
          const SizedBox(height: 8),
        ],
      ),
    );

    // 2. Optional onTap → InkWell
    if (onTap != null) {
      card = Material(
        color: Colors.transparent,
        child: InkWell(borderRadius: BorderRadius.circular(12), onTap: onTap, child: card),
      );
    }

    // 3. Sizing: if width/height → SizedBox,
    //   otherwise → rozciągnij na wszystkie osie
    if (width != null || height != null) {
      card = SizedBox(width: width, height: height, child: card);
    } else {
      /// Completely fills available area of the parent
      card = SizedBox.expand(child: card);
    }

    return card;
  }
}
