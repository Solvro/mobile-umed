import "package:flutter/material.dart";
import "../../app/config/ui_config.dart";

class SheetTopHandle extends SliverPersistentHeaderDelegate {
  const SheetTopHandle({this.controls});

  final Widget? controls;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: getTopDecoration(),
      padding: const EdgeInsets.symmetric(vertical: BottomSheetConfig.smallVerticalPadding),
      height: maxExtent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _SheetHandle(),
          const SizedBox(height: BottomSheetHeaderConfig.handleContentSpacing),
          if (controls != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: BottomSheetConfig.horizontalPadding),
              child: controls,
            ),
        ],
      ),
    );
  }

  @override
  double get minExtent =>
      controls != null ? BottomSheetHeaderConfig.headerWithControls : BottomSheetHeaderConfig.headerWithoutControls;
  @override
  double get maxExtent =>
      controls != null ? BottomSheetHeaderConfig.headerWithControls : BottomSheetHeaderConfig.headerWithoutControls;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

class _SheetHandle extends StatelessWidget {
  const _SheetHandle();

  @override
  Widget build(BuildContext context) {
    return const Column(children: [_LineHandle(), SizedBox(height: 6), _LineHandle()]);
  }
}

class _LineHandle extends StatelessWidget {
  const _LineHandle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: BottomSheetHeaderConfig.handleLength,
      height: BottomSheetHeaderConfig.handleWidth,
      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(100)),
    );
  }
}

BoxDecoration getTopDecoration() => const BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.vertical(top: Radius.circular(BottomSheetHeaderConfig.roundedTopRadius)),
);
