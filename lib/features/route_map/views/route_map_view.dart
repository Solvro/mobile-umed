import "dart:async";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../app/l10n/l10n.dart";
import "../../../app/theme/app_theme.dart";
import "../../../common/providers/bottom_sheet_providers.dart";
import "../../../common/utils/location_service.dart";
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

class RouteMapViewState extends ConsumerState<RouteMapView> {
  late SheetMode _currentSheetMode;
  late SheetState _currentSheetState;

  Future<void> _centerToUserLocation() async {
    final latLng = await LocationService.getCurrentLatLng();

    if (latLng != null) {
      ref.read(mapControllerProvider).move(latLng, 14);
    }
  }

  @override
  void initState() {
    super.initState();
    _currentSheetMode = ref.read(sheetModeProvider);
    _currentSheetState = ref.read(sheetStateProvider);
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
              AsyncData(:final value) => RouteMapWidget(
                active: _currentSheetState == SheetState.hidden,
                optionalRoutes: value,
              ),
              AsyncLoading() => const CircularProgressIndicator(),
              _ => Center(child: Text(context.l10n.errors_generic)),
            },
            _SheetHidingHittest(currentSheetState: _currentSheetState),
            SelectRouteBottomSheet(),
          ],
        ),
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          RouteMapWidget(route: route, active: _currentSheetState == SheetState.hidden),
          _SheetHidingHittest(currentSheetState: _currentSheetState),
          RouteProgressBar(landmarks: route.landmarks),
          const RouteBottomSheet(),
          Positioned(
            top: 75,
            right: 12,
            child: FloatingActionButton.small(onPressed: _centerToUserLocation, child: const Icon(Icons.my_location)),
          ),
        ],
      ),
    );
  }
}

class _SheetHidingHittest extends ConsumerWidget {
  const _SheetHidingHittest({required this.currentSheetState});
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
