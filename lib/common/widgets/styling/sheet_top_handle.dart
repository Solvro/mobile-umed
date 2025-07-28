import "package:flutter/material.dart";
import "../../../app/config/ui_config.dart";
import "../../../app/theme/app_theme.dart";

class SheetTopHandle extends SliverPersistentHeaderDelegate {
  const SheetTopHandle({this.controls});

  final Widget? controls;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: getSheetTopDecoration(context.colorScheme.surface),
      padding: const EdgeInsets.symmetric(vertical: AppPaddings.tiny),
      height: maxExtent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.drag_handle, size: BottomSheetHeaderConfig.handleIconSize),
          if (controls != null)
            Padding(padding: const EdgeInsets.symmetric(horizontal: AppPaddings.medium), child: controls),
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
  bool shouldRebuild(covariant SheetTopHandle oldDelegate) => oldDelegate.controls != controls;
}

BoxDecoration getSheetTopDecoration(Color color) => BoxDecoration(
  color: color,
  borderRadius: const BorderRadius.vertical(top: Radius.circular(BottomSheetHeaderConfig.roundedTopRadius)),
);
