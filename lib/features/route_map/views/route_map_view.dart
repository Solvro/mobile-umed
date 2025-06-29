import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../app/l10n/l10n.dart";
import "../../../app/theme/app_theme.dart";
import "../../../common/providers/bottom_sheet_providers.dart";
import "../../../common/utils/location_service.dart";
import "../providers/route_provider.dart";
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
  late final StateController<dynamic> _routeController;

  final GlobalKey<RouteMapWidgetState> _mapKey = GlobalKey();

  Future<void> _centerToUserLocation() async {
    final latLng = await LocationService.getCurrentLatLng();

    if (latLng != null) {
      _mapKey.currentState?.moveTo(latLng);
    }
  }

  @override
  void initState() {
    super.initState();
    _currentSheetMode = ref.read(sheetModeProvider);
    _currentSheetState = ref.read(sheetStateProvider);
    _routeController = ref.read(routeProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final route = ref.watch(routeProvider);

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
          children: [RouteMapWidget(active: _currentSheetState == SheetState.hidden), SelectRouteBottomSheet()],
        ),
      );
    }
    return Scaffold(
      body: Stack(
        children: [
          RouteMapWidget(route: route, active: _currentSheetState == SheetState.hidden),
          RouteProgressBar(landmarks: route.landmarks),
          const RouteBottomSheet(),
          Positioned(
            top: 112,
            right: 12,
            child: FloatingActionButton.small(onPressed: _centerToUserLocation, child: const Icon(Icons.my_location)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    unawaited(
      Future(() {
        _routeController.state = null;
      }),
    );
    super.dispose();
  }
}
