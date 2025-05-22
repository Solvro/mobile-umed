import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../common/data_source/mocks/mock_routes.dart";
import "providers/route_provider.dart";
import "views/route_map_view.dart";

class RouteMapPage extends ConsumerWidget {
  const RouteMapPage({super.key, this.id});

  final int? id;
  static const routeName = "/route_map";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (id != null) {
      Future.microtask(() {
        ref.read(routeProvider.notifier).state = mockData[id!];
      });
    } else {
      Future.microtask(() {
        ref.read(routeProvider.notifier).state = null;
      });
    }
    return const RouteMapView();
  }
}
