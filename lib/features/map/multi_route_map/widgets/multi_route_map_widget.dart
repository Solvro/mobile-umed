import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../app/config/flutter_map_config.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/theme/app_theme.dart";
import "../../../../common/providers/cache_tile.dart";
import "../../../error/views/full_screen_error_view.dart";
import "../../route_map/providers/route_provider.dart";
import "route_selections_polyline.dart";

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
      AsyncError() => const FullScreenErrorView(),
      AsyncData(:final value) => FlutterMap(
        options: const MapOptions(initialCenter: MapConfig.wroclawCenter),
        mapController: _mapController,
        children: [
          TileLayer(urlTemplate: FlutterMapConfig.urlTemplate, maxZoom: MapConfig.maxZoom, tileProvider: value),
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
