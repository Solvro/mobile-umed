import "package:flutter/material.dart";
import "../../../app/config/ui_config.dart";

class ShimmerSwitcher extends StatelessWidget {
  final bool isLoading;
  final Widget shimmer;
  final Widget child;
  final Duration duration;

  const ShimmerSwitcher({
    super.key,
    required this.isLoading,
    required this.shimmer,
    required this.child,
    this.duration =
        const Duration(milliseconds: ShimmerConfig.millisecounds500),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: duration, child: isLoading ? shimmer : child);
  }
}
