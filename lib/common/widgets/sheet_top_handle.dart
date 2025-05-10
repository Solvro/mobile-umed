import "package:flutter/material.dart";

class SheetTopHandle extends SliverPersistentHeaderDelegate {
  const SheetTopHandle({this.controls});

  final Widget? controls;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: const BoxDecoration(color: Colors.red, borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      padding: const EdgeInsets.all(8),
      height: maxExtent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [const _SheetHandle(), const SizedBox(height: 15), if (controls != null) controls!],
      ),
    );
  }

  @override
  double get minExtent => controls != null ? 100 : 40;
  @override
  double get maxExtent => controls != null ? 100 : 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

class _SheetHandle extends StatelessWidget {
  const _SheetHandle();

  @override
  Widget build(BuildContext context) {
    return const Column(children: [LineHandle(), SizedBox(height: 6), LineHandle()]);
  }
}

class LineHandle extends StatelessWidget {
  const LineHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 4,
      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(100)),
    );
  }
}
