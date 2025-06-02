import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../app/app.dart";
import "../route_map/repository/route_map_repository.dart";
import "../route_map/widgets/modals/route_completed_modal.dart";

class DebugPlayground extends StatelessWidget {
  const DebugPlayground({super.key});

  static const String routeName = "/debug_playground";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Debug Playground")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(onPressed: () async => context.router.pushRouteMap(2), child: const Text("Route Map")),
            OutlinedButton(
              onPressed:
                  () async => showDialog<RouteCompletedModal>(
                    context: context,
                    builder: (context) => const RouteCompletedModal(),
                  ),
              child: const Text("Route Completed Modal"),
            ),
            const TestProviderWidget(),
          ],
        ),
      ),
    );
  }
}

class TestProviderWidget extends ConsumerWidget {
  const TestProviderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routes = ref.watch(fetchAllRoutesProvider);
    final route_2 = ref.watch(fetchRouteWithIdProvider(2));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        routes.when(
          data: (routes) => Text("Routes:\n$routes"),
          loading: CircularProgressIndicator.new,
          error: (e, _) => Text("Error: $e"),
        ),
        route_2.when(
          data: (route) => Text("\nRoute 2:\n$route"),
          loading: CircularProgressIndicator.new,
          error: (e, _) => Text("Error: $e"),
        ),
      ],
    );
  }
}
