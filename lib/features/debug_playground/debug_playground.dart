import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../app/app.dart";
import "../../common/data_source/mocks/mock_routes.dart";
import "../../common/models/completed_route.dart";
import "../../common/providers/completed_routes_provider.dart";
import "../map/route_map/controllers/route_controller.dart";
import "../map/route_map/modals/route_completed_modal.dart";
import "../map/route_map/repository/route_map_repository.dart";
import "widgets/shimmer_test_widget.dart";

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
            OutlinedButton(onPressed: () async => context.router.pushMultiRouteMap(), child: const Text("RouteMap")),
            OutlinedButton(
              onPressed:
                  () async => showDialog(
                    context: context,
                    builder:
                        (context) =>
                            RouteCompletedModal(route: mockData[0], time: const Duration(hours: 2, minutes: 3)),
                  ),
              child: const Text("Show modal"),
            ),
            OutlinedButton(
              onPressed: () async => context.router.pushRouteMap(71),
              child: const Text("RouteMap with route"),
            ),

            OutlinedButton(
              onPressed: () async => context.router.pushFullScreenError("Oto testowy error. lorem ipsum i tak dalej"),
              child: const Text("Error Page"),
            ),
            const Text("Test Shimmera"),
            const ShimmerTestWidget(),
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
    final completed = ref.watch(completedRoutesProvider);

    final count = ref.watch(visitedCountProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        OutlinedButton(
          onPressed: () {
            ref.read(visitedCountProvider.notifier).incrementVisited();
          },
          child: Text("Visit Next Landmark, current: $count"),
        ),
        OutlinedButton(
          onPressed: () {
            ref.read(visitedCountProvider.notifier).resetVisited();
          },
          child: const Text("Reset"),
        ),
        OutlinedButton(
          onPressed: () async {
            final route = CompletedRoute(
              dateCompleted: DateTime.now(),
              routeId: 2,
              water: 600,
              distance: 8,
              calories: 450,
              time: 42,
            );
            await ref.read(completedRoutesProvider.notifier).addCompletedRoute(route);
          },
          child: const Text("Complete route 2"),
        ),
        OutlinedButton(
          onPressed: () async {
            final route = CompletedRoute(
              dateCompleted: DateTime.now(),
              routeId: 4,
              water: 1600,
              distance: 8.4,
              calories: 450,
              time: 42,
            );
            await ref.read(completedRoutesProvider.notifier).addCompletedRoute(route);
          },
          child: const Text("Complete route 4"),
        ),
        OutlinedButton(
          onPressed: () async {
            await ref.read(completedRoutesProvider.notifier).resetAllProgress();
          },
          child: const Text("Clear completed routes"),
        ),
        completed.when(
          data: (data) => Text("Completed:\n$data"),
          loading: CircularProgressIndicator.new,
          error: (e, _) => Text("Error: $e"),
        ),
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
