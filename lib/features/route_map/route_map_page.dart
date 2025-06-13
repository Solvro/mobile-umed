import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../app/app.dart";
import "../error/error_page.dart";
import "repository/route_map_repository.dart";
import "views/route_map_view.dart";

class RouteMapPage extends ConsumerWidget {
  const RouteMapPage({super.key, required this.id});

  final int id;
  static const routeName = "/route_map";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeProvider = ref.watch(fetchRouteWithIdProvider(id));
    return switch (routeProvider) {
      AsyncData(:final value) => RouteMapView(route: value),
      AsyncError(:final error) => ErrorPage(onBackToHome: context.router.goHome, message: error.toString()),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
