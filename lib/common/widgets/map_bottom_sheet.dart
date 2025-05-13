import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../app/config/ui_config.dart";
import "../models/bottom_sheet_mode.dart";
import "sheet_top_handle.dart";

class MapBottomSheet extends ConsumerWidget {
  const MapBottomSheet({super.key, required this.child, required this.button, this.controls});

  final Widget? controls;
  final Widget child;
  final Widget button;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(sheetModeProvider);
    final sheetPosition =
        mode == SheetMode.half ? BottomSheetConfig.halfSizePercent : BottomSheetConfig.fullSizePercent;
    return Stack(
      children: [
        Positioned(
          bottom: BottomSheetConfig.fixedBottomSpace,
          left: 0,
          right: 0,
          top: BottomSheetConfig.fixedBottomSpace,
          child: DraggableScrollableSheet(
            snap: true,
            initialChildSize: BottomSheetConfig.hiddenSizePercent,
            minChildSize: BottomSheetConfig.hiddenSizePercent,
            maxChildSize: sheetPosition,
            builder: (context, scrollController) {
              return DecoratedBox(
                decoration: getTopDecoration(),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverPersistentHeader(pinned: true, delegate: SheetTopHandle(controls: controls)),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: BottomSheetConfig.horizontalPadding),
                        child: child,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: BottomSheetConfig.fixedBottomSpace,
            color: Colors.white,
            child: SafeArea(
              top: false,
              child: Align(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: BottomSheetConfig.horizontalPadding,
                    vertical: BottomSheetConfig.mainButtonVerticalPadding,
                  ),
                  child: button,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
