import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../app/app.dart";
import "../../common/models/completed_route.dart";
import "../../common/utils/completed_route_storage_utils.dart";
import "../route_map/controllers/route_controller.dart";
import "../route_map/repository/route_map_repository.dart";
import "../route_map/widgets/modals/route_completed_modal.dart";

class DebugPlayground extends StatefulWidget {
  const DebugPlayground({super.key});

  static const String routeName = "/debug_playground";

  @override
  State<DebugPlayground> createState() => _DebugPlaygroundState();
}

class _DebugPlaygroundState extends State<DebugPlayground> {
  String _routesInfo = "";

  Future<void> _loadRoutesFromHive() async {
    final routes = await getAllCompletedRoutes();
    setState(() {
      _routesInfo =
          routes.isEmpty
              ? "No completed routes saved."
              : routes
                  .map((r) {
                    return """
                    Route ID: ${r.routeId}
                    Date: ${r.dateCompleted}
                    Distance: ${r.distance} km
                    Time: ${r.time} min
                    Tempo: ${r.tempo} min/km
                    Water: ${r.water} ml
                    Calories: ${r.calories} kcal
                    ---
                    """;
                  })
                  .join("\n");
    });
  }

  @override
  void initState() {
    super.initState();
    _loadRoutesFromHive();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Debug Playground")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            OutlinedButton(onPressed: () async => context.router.pushRouteMap(), child: const Text("RouteMap")),
            OutlinedButton(
              onPressed: () async => context.router.pushRouteMapWithRoute(2),
              child: const Text("RouteMap with route"),
            ),
            OutlinedButton(
              onPressed:
                  () async => showDialog<RouteCompletedModal>(
                    context: context,
                    builder: (context) => const RouteCompletedModal(),
                  ),
              child: const Text("Route Completed Modal"),
            ),
            OutlinedButton(
              onPressed: () => context.router.pushFullScreenError("Oto testowy error. lorem ipsum i tak dalej"),
              child: const Text("Error Page"),
            ),
            OutlinedButton(
              onPressed: () async {
                final route = CompletedRoute(
                  dateCompleted: DateTime.now(),
                  routeId: 3,
                  water: 600,
                  distance: 8,
                  calories: 450,
                  time: 42,
                  tempo: 5.2,
                );
                await saveCompletedRoute(route);
                await _loadRoutesFromHive();
              },
              child: const Text("Complete route 2"),
            ),
            Text(_routesInfo),
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
