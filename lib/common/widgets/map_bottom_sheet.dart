import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../app/config/ui_config.dart";
import "../../app/theme/app_theme.dart";
import "../providers/bottom_sheet_providers.dart";
import "sheet_top_handle.dart";

class MapBottomSheet extends ConsumerStatefulWidget {
  const MapBottomSheet({super.key, required this.child, required this.button, this.controls});
  final Widget? controls;
  final Widget child;
  final Widget button;

  @override
  ConsumerState<MapBottomSheet> createState() => _MapBottomSheetState();
}

class _MapBottomSheetState extends ConsumerState<MapBottomSheet> {
  final DraggableScrollableController controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      final currentPosition = controller.size;
      ref.read(sheetStateProvider.notifier).state =
          currentPosition < BottomSheetConfig.hiddenSizePercent + BottomSheetConfig.tolerance
              ? SheetState.hidden
              : SheetState.visible;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mode = ref.watch(sheetModeProvider);
    final sheetPosition =
        mode == SheetMode.half ? BottomSheetConfig.halfSizePercent : BottomSheetConfig.fullSizePercent;

    ref.listen<bool>(sheetTriggerProvider, (previous, shouldTrigger) async {
      if (shouldTrigger) {
        ref.read(sheetTriggerProvider.notifier).state = false;
        await controller.animateTo(
          ref.read(sheetStateProvider) == SheetState.hidden ? BottomSheetConfig.hiddenSizePercent : sheetPosition,
          // BottomSheetConfig.hiddenSizePercent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    return Stack(
      children: [
        _BottomSheetDraggableArea(
          controller: controller,
          sheetPosition: sheetPosition,
          controls: widget.controls,
          child: widget.child,
        ),
        _BottomSheetFixedButton(button: widget.button),
      ],
    );
  }
}

class _BottomSheetDraggableArea extends StatelessWidget {
  const _BottomSheetDraggableArea({
    required this.controller,
    required this.sheetPosition,
    required this.child,
    required this.controls,
  });

  final DraggableScrollableController controller;
  final double sheetPosition;
  final Widget child;
  final Widget? controls;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: BottomSheetConfig.fixedBottomSpace,
      left: 0,
      right: 0,
      top: 0,
      child: DraggableScrollableSheet(
        snap: true,
        controller: controller,
        initialChildSize: BottomSheetConfig.hiddenSizePercent,
        minChildSize: BottomSheetConfig.hiddenSizePercent,
        maxChildSize: sheetPosition,
        builder: (context, scrollController) {
          return DecoratedBox(
            decoration: getSheetTopDecoration(context.colorScheme.surface),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverPersistentHeader(pinned: true, delegate: SheetTopHandle(controls: controls)),
                SliverToBoxAdapter(
                  child: Padding(padding: const EdgeInsets.symmetric(horizontal: AppPaddings.medium), child: child),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BottomSheetFixedButton extends StatelessWidget {
  const _BottomSheetFixedButton({required this.button});

  final Widget button;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: BottomSheetConfig.fixedBottomSpace,
        color: context.colorScheme.surface,
        child: SafeArea(
          top: false,
          child: Align(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPaddings.medium, vertical: AppPaddings.tinySmall),
              child: button,
            ),
          ),
        ),
      ),
    );
  }
}
