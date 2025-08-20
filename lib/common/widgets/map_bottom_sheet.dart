import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../app/config/ui_config.dart";
import "../../app/theme/app_theme.dart";
import "../providers/bottom_sheet_providers.dart";
import "styling/sheet_top_handle.dart";

class MapBottomSheet extends ConsumerStatefulWidget {
  const MapBottomSheet({super.key, required this.child, required this.button, this.controls, this.draggableAreaHeight});
  final Widget? controls;
  final Widget child;
  final Widget button;
  final int? draggableAreaHeight;

  @override
  ConsumerState<MapBottomSheet> createState() => _MapBottomSheetState();
}

class _MapBottomSheetState extends ConsumerState<MapBottomSheet> {
  final DraggableScrollableController controller = DraggableScrollableController();
  // DraggableScrollableSheet does not shrink-wrap to its child height.
  // Its size must be calculated dynamically and provided explicitly.
  late final double halfPosition;
  late double initialSheetPosition;
  bool isAnimating = false;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      final currentPosition = controller.size;
      if (isAnimating) return;
      ref.read(sheetStateProvider.notifier).state =
          currentPosition < BottomSheetConfig.hiddenSizePercent + BottomSheetConfig.tolerance
              ? SheetState.hidden
              : SheetState.visible;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.draggableAreaHeight == null) {
      halfPosition = BottomSheetConfig.halfSizeDefaultPercent;
    } else {
      final mediaQuery = MediaQuery.of(context);
      final availableHeight =
          mediaQuery.size.height -
          mediaQuery
              .viewPadding
              .top // doesn't include keyboard
              -
          mediaQuery
              .padding
              .bottom // includes keyboard
              -
          BottomSheetConfig.fixedBottomSpace;

      halfPosition = (widget.draggableAreaHeight! / availableHeight).clamp(BottomSheetConfig.hiddenSizePercent, 1);
    }

    initialSheetPosition = _calculatePosition(ref, context, widget.draggableAreaHeight);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newInitialSheetPosition = _calculatePosition(ref, context, widget.draggableAreaHeight);
    // do not set initial sheet position smaller than the previous one while animating
    if (!isAnimating || newInitialSheetPosition > initialSheetPosition) {
      initialSheetPosition = newInitialSheetPosition;
    }

    ref.listen<bool>(sheetTriggerProvider, (previous, shouldTrigger) async {
      if (shouldTrigger) {
        // in case of rebuild inform about the animation
        // cannot modify the widget state explicitly because there is an old closure inside this listener
        isAnimating = true;
        ref.read(sheetTriggerProvider.notifier).state = false;
        final targetPosition =
            ref.read(sheetStateProvider) == SheetState.visible
                ? _calculatePosition(ref, context, widget.draggableAreaHeight)
                : BottomSheetConfig.hiddenSizePercent;
        await Future.delayed(Duration.zero, () async {
          await controller.animateTo(
            targetPosition,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
        isAnimating = false;
      }
    });

    return Stack(
      children: [
        _BottomSheetDraggableArea(
          controller: controller,
          initialSheetPosition: initialSheetPosition,
          controls: widget.controls,
          child: widget.child,
        ),
        _BottomSheetFixedButton(button: widget.button),
      ],
    );
  }

  double _calculatePosition(WidgetRef ref, BuildContext context, int? draggableAreaHeight) {
    final mode = ref.read(sheetModeProvider);
    final sheetPosition = mode == SheetMode.half ? halfPosition : BottomSheetConfig.fullSizePercent;
    return sheetPosition;
  }
}

class _BottomSheetDraggableArea extends StatelessWidget {
  const _BottomSheetDraggableArea({
    required this.controller,
    required this.initialSheetPosition,
    required this.child,
    required this.controls,
  });

  final DraggableScrollableController controller;
  final double initialSheetPosition;
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
        maxChildSize: initialSheetPosition,
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
