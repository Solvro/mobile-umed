import "dart:collection";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../app/config/flutter_map_config.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/l10n/l10n.dart";
import "../../../../app/theme/app_theme.dart";
import "../../../../common/providers/bottom_sheet_providers.dart";
import "../../../../common/providers/cache_tile.dart";
import "../../route_map/controllers/route_controller.dart";
import "../../route_map/providers/locations_provider.dart";
import "../../route_map/providers/route_provider.dart";
import "../../route_map/repository/route_map_repository.dart";
import "../../route_map/views/route_map_view.dart";
import "../../route_map/widgets/bottom_sheet/select_route_bottom_sheet.dart";
import "../../route_map/widgets/map/route_selections_polyline.dart";

class MultiRouteView extends ConsumerStatefulWidget {
  const MultiRouteView({super.key});

  @override
  ConsumerState<MultiRouteView> createState() => _MultiRouteViewState();
}

class _MultiRouteViewState extends ConsumerState<MultiRouteView> {
  void _initializeState(WidgetRef ref) {
    ref.read(sheetStateProvider.notifier).state = SheetState.visible;
    ref.read(sheetModeProvider.notifier).state = SheetMode.expanded;
    ref.read(passedLocationsProvider.notifier).state = 0;
    ref.read(visitedCountProvider.notifier).resetVisited();
    ref.read(expandedRoutesProvider.notifier).state = LinkedHashSet();
    if (ref.read(sheetStateProvider) == SheetState.visible) {
      // TODO(24bartixx): remove after fixing starting route
      ref.read(sheetTriggerProvider.notifier).state = true;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeState(ref);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final allRoutes = ref.watch(fetchAllRoutesProvider);
    final currentSheetState = ref.watch(sheetStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.choose_route),
        foregroundColor: colorScheme.onPrimary,
        backgroundColor: colorScheme.primary,
      ),
      body: Stack(
        children: [
          switch (allRoutes) {
            AsyncData() => const MultiRouteMapWidget(),
            AsyncLoading() => const CircularProgressIndicator(),
            _ => Center(child: Text(context.l10n.errors_generic)),
          },
          SheetHidingHitTest(currentSheetState: currentSheetState),
          SelectRouteBottomSheet(),
        ],
      ),
    );
  }
}

class MultiRouteMapWidget extends ConsumerStatefulWidget {
  const MultiRouteMapWidget({super.key});

  @override
  ConsumerState<MultiRouteMapWidget> createState() => _MultiRouteMapWidgetState();
}

class _MultiRouteMapWidgetState extends ConsumerState<MultiRouteMapWidget> {
  late final MapController _mapController;

  @override
  void initState() {
    _mapController = MapController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final expandedRoutes = ref.watch(expandedRoutesProvider);
    final tileProvider = ref.watch(cacheTileProvider);

    return switch (tileProvider) {
      AsyncError(:final error) => Center(child: Text("Error: $error")),
      AsyncData(:final value) => FlutterMap(
        options: const MapOptions(initialCenter: MapConfig.wroclawCenter),
        mapController: _mapController,
        children: [
          TileLayer(urlTemplate: FlutterMapConfig.urlTemplate, maxZoom: 19, tileProvider: value),
          if (expandedRoutes.isNotEmpty)
            RouteSelectionsPolyline(
              locations: expandedRoutes.asList().map((r) => r.route).toIList(),
              lastInteracted: expandedRoutes.last,
              selectedColor: context.colorScheme.primary,
              notSelectedColor: MapConfig.unvisitedColor,
            ),
        ],
      ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
