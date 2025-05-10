import "package:flutter/material.dart";

class SheetTopHandle extends SliverPersistentHeaderDelegate {
  const SheetTopHandle({required this.controls});

  final Widget controls;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: const BoxDecoration(color: Colors.red, borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      padding: const EdgeInsets.all(8),

      height: maxExtent,
      child: Column(
        spacing: 5,
        mainAxisSize: MainAxisSize.min,
        children: [const LineHandle(), const LineHandle(), const SizedBox(height: 10), controls],
      ),
    );
  }

  @override
  double get minExtent => 100;
  @override
  double get maxExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

class LineHandle extends StatelessWidget {
  const LineHandle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 4,
      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(100)),
    );
  }
}
