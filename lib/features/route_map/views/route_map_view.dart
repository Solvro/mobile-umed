import "dart:async";
import "package:flutter/material.dart";
import "package:flutter_map_animations/flutter_map_animations.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../app/l10n/l10n.dart";
import "../../../app/theme/app_theme.dart";
import "../../../common/providers/bottom_sheet_providers.dart";
import "../../../common/utils/location_service.dart";
import "../../../common/utils/modal_before_exiting.dart";
import "../modals/end_route_modal.dart";
import "../providers/route_provider.dart";
import "../repository/route_map_repository.dart";
import "../widgets/bottom_sheet/route_bottom_sheet.dart";
import "../widgets/bottom_sheet/select_route_bottom_sheet.dart";
import "../widgets/map/route_map_widget.dart";
import "../widgets/progress_bar/route_progress_bar.dart";

class RouteMapView extends ConsumerStatefulWidget {
  const RouteMapView({super.key});

  @override
  RouteMapViewState createState() => RouteMapViewState();
}

class RouteMapViewState extends ConsumerState<RouteMapView> with TickerProviderStateMixin {
  late final AnimatedMapController _mapController;

  late SheetMode _currentSheetMode;
  late SheetState _currentSheetState;

  @override
  void initState() {
    super.initState();
    _mapController = AnimatedMapController(vsync: this);
    _currentSheetMode = ref.read(sheetModeProvider);
    _currentSheetState = ref.read(sheetStateProvider);
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _centerToUserLocation() async {
    final latLng = await LocationService.getCurrentLatLng();
    if (latLng == null || !mounted) return;
    await _mapController.animateTo(
      dest: latLng,
      zoom: 14,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final route = ref.watch(routeProvider);
    final allRoutesAsync = ref.watch(fetchAllRoutesProvider);

    ref.listen<SheetMode>(sheetModeProvider, (previous, next) {
      if (next != _currentSheetMode) {
        setState(() => _currentSheetMode = next);
      }
    });

    ref.listen<SheetState>(sheetStateProvider, (previous, next) {
      if (next != _currentSheetState) {
        setState(() => _currentSheetState = next);
      }
    });

    if (route == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.choose_route),
          foregroundColor: context.colorScheme.onPrimary,
          backgroundColor: context.colorScheme.primary,
        ),
        body: Stack(
          children: [
            switch (allRoutesAsync) {
              AsyncData() => RouteMapWidget(
                controller: _mapController,
                active: _currentSheetState == SheetState.hidden,
              ),
              AsyncLoading() => const CircularProgressIndicator(),
              _ => Center(child: Text(context.l10n.errors_generic)),
            },
            _SheetHidingHitTest(currentSheetState: _currentSheetState),
            SelectRouteBottomSheet(),
          ],
        ),
      );
    }
    return ModalBeforeExiting(
      modal: const EndRouteModal(),
      child: Scaffold(
        body: Stack(
          children: [
            RouteMapWidget(controller: _mapController, route: route, active: _currentSheetState == SheetState.hidden),
            _SheetHidingHitTest(currentSheetState: _currentSheetState),
            RouteProgressBar(checkpoints: route.checkpoints),
            const RouteBottomSheet(),
            Positioned(
              top: MediaQuery.of(context).padding.top + 56,
              right: 16,
              child: FloatingActionButton.small(onPressed: _centerToUserLocation, child: const Icon(Icons.my_location)),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetHidingHitTest extends ConsumerWidget {
  const _SheetHidingHitTest({required this.currentSheetState});
  final SheetState currentSheetState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned.fill(
      child: IgnorePointer(
        ignoring: currentSheetState == SheetState.hidden,
        child: Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (_) {
            ref.read(sheetStateProvider.notifier).state = SheetState.hidden;
            ref.read(sheetTriggerProvider.notifier).state = true;
          },
        ),
      ),
    );
  }
}
