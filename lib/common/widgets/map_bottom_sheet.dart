import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../models/bottom_sheet_mode.dart";

class MapBottomSheet extends ConsumerWidget {
  const MapBottomSheet({super.key, required this.child, required this.button, required this.controls});

  final SliverPersistentHeaderDelegate controls;
  final Widget child;
  final ElevatedButton button;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(sheetModeProvider);
    const topBottomOffset = 80.0;
    final sheetPosition = mode == SheetMode.half ? 0.3 : 0.5;
    return Stack(
      children: [
        Positioned(
          bottom: topBottomOffset,
          left: 0,
          right: 0,
          top: topBottomOffset,
          child: DraggableScrollableSheet(
            snap: true,
            initialChildSize: sheetPosition,
            minChildSize: 0.05,
            maxChildSize: sheetPosition,
            builder: (context, scrollController) {
              return ColoredBox(
                color: Colors.white,
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    // Title at the top
                    SliverPersistentHeader(pinned: true, delegate: controls),
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
          child: SizedBox(
            height: topBottomOffset,
            child: ColoredBox(color: Colors.white, child: SafeArea(top: false, child: Center(child: button))),
          ),
        ),
      ],
    );
  }
}
