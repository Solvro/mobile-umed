import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../app/config/ui_config.dart";
import "../../app/app.dart";
import "../../common/data_source/mocks/mock_routes.dart";
import "../../common/models/completed_route.dart";
import "../../common/models/creator.dart";
import "../../common/providers/completed_routes_provider.dart";
import "../../common/widgets/common/horizontal_routes_list/horizontal_routes_list.dart";
import "../../common/widgets/common/shimmer/creator_title_shimmer.dart";
import "../../common/widgets/common/shimmer/horizontal_routes_shimmer.dart";
import "../../features/info/widgets/creator_tile.dart";
import "../route_map/controllers/route_controller.dart";
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

// Dodaj definicję ShimmerTestWidget poniżej klasy DebugPlayground (lub w osobnym pliku)
class ShimmerTestWidget extends StatefulWidget {
  const ShimmerTestWidget({super.key});

  @override
  State<ShimmerTestWidget> createState() => _ShimmerTestWidgetState();
}

class _ShimmerTestWidgetState extends State<ShimmerTestWidget> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final mockRoutes = mockData;
    const mockCreator = Creator(
      id: 1,
      firstName: "Jan",
      lastName: "Kowalski",
      imageUrl: "",
      role: "Developer",
      sort: 0,
    );

    return Column(
      children: [
        const SizedBox(height: 4),
        SwitchListTile(
          title: const Text("Przełącz ładowanie"),
          value: isLoading,
          onChanged: (val) => setState(() => isLoading = val),
        ),
        const SizedBox(height: 16),
        const Text("Shimmer dla listy tras"),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: ShimmerConfig.milisecounds500),
          child:
              isLoading
                  ? const RouteListShimmer(key: ShimmerConfig.shimmerKey)
                  : RouteListWidget(
                    key: ShimmerConfig.listKey,
                    routes: mockRoutes,
                    onRouteTap: (_) {},
                    icon: Icons.arrow_forward_ios,
                  ),
        ),
        const SizedBox(height: 32),
        const Text("Shimmer twórcy"),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: ShimmerConfig.milisecounds500),
          child:
              isLoading
                  ? const CreatorTileShimmer(key: ShimmerConfig.shimmerKey)
                  : const CreatorTile(mockCreator, key: ShimmerConfig.creatorKey),
        ),
      ],
    );
  }
}
