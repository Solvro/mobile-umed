import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../app/app.dart";
import "../error/error_page.dart";
import "providers/route_provider.dart";
import "repository/route_map_repository.dart";
import "views/route_map_view.dart";

class RouteMapPage extends ConsumerWidget {
  const RouteMapPage({super.key, this.id});

  final int? id;
  static const routeName = "/route_map";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (id == null) {
      return const RouteMapView();
    }

    final routeAsync = ref.watch(fetchRouteWithIdProvider(id!));

    return routeAsync.when(
      data: (route) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(routeProvider.notifier).state = route;
        });
        return const RouteMapView();
      },
      error: (error, _) => ErrorPage(onBackToHome: context.router.goHome, message: error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
