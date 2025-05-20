import "package:flutter/material.dart";
import "../../app/config/ui_config.dart";
import "../../app/theme/app_theme.dart";

class SheetTopHandle extends SliverPersistentHeaderDelegate {
  const SheetTopHandle({this.controls});

  final Widget? controls;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: getSheetTopDecoration(context.colorScheme.surface),
      padding: const EdgeInsets.symmetric(vertical: AppPaddings.verticalSmall),
      height: maxExtent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.drag_handle, size: BottomSheetHeaderConfig.handleIconSize),
          if (controls != null)
            Padding(padding: const EdgeInsets.symmetric(horizontal: AppPaddings.horizontalMedium), child: controls),
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

BoxDecoration getSheetTopDecoration(Color color) => BoxDecoration(
  color: color,
  borderRadius: const BorderRadius.vertical(top: Radius.circular(BottomSheetHeaderConfig.roundedTopRadius)),
);
