import "package:flutter/material.dart" hide Route;
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../app/app.dart";
import "../../common/models/route.dart";
import "../../common/providers/bottom_sheet_providers.dart";
import "../error/error_page.dart";
import "controllers/route_controller.dart";
import "providers/locations_provider.dart";
import "providers/route_provider.dart";
import "repository/route_map_repository.dart";
import "views/route_map_view.dart";

class RouteMapPage extends ConsumerWidget {
  const RouteMapPage({super.key, this.id});

  final int? id;
  static const routeName = "/route_map";

  void _initializeState(WidgetRef ref, {Route? route}) {
    ref.read(routeProvider.notifier).state = route;
    ref.read(sheetStateProvider.notifier).state = SheetState.hidden;
    ref.read(passedLocationsProvider.notifier).state = 0;
    ref.read(visitedCountProvider.notifier).resetVisited();
    ref.read(selectedRoutesProvider.notifier).state = [];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (id == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _initializeState(ref);
      });
      return const RouteMapView();
    }

    final routeAsync = ref.watch(fetchRouteWithIdProvider(id!));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (routeAsync is AsyncData) {
        _initializeState(ref, route: routeAsync.value);
      }
    });

    return switch (routeAsync) {
      AsyncData() => const RouteMapView(),
      AsyncError(:final error) => ErrorPage(onBackToHome: context.router.goHome, message: error.toString()),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
