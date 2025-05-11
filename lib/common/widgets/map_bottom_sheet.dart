import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
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
    const topBottomOffset = 80.0;
    final sheetPosition = mode == SheetMode.half ? 0.26 : 0.45;
    return Stack(
      children: [
        Positioned(
          bottom: topBottomOffset,
          left: 0,
          right: 0,
          top: topBottomOffset,
          child: DraggableScrollableSheet(
            snap: true,
            initialChildSize: 0.05,
            minChildSize: 0.05,
            maxChildSize: sheetPosition,
            builder: (context, scrollController) {
              return DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverPersistentHeader(pinned: true, delegate: SheetTopHandle(controls: controls)),
                    SliverToBoxAdapter(child: child),
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
            height: topBottomOffset,
            color: Colors.white,
            child: SafeArea(
              top: false,
              child: Align(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: button)),
            ),
          ),
        ),
      ],
    );
  }
}
