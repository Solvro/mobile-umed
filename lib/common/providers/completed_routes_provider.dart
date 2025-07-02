import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:hive/hive.dart";
import "../../features/route_map/repository/route_map_repository.dart";
import "../models/completed_route.dart";

const String completedRoutesBoxName = "completed_routes";

final completedRoutesProvider = AsyncNotifierProvider<CompletedRoutesNotifier, List<CompletedRoute>>(
  CompletedRoutesNotifier.new,
);

class CompletedRoutesNotifier extends AsyncNotifier<List<CompletedRoute>> {
  @override
  Future<List<CompletedRoute>> build() async {
    await Hive.openBox<Map<dynamic, dynamic>>(completedRoutesBoxName);
    try {
      final remoteRoutes = await ref.read(fetchAllRoutesProvider.future);
      final box = Hive.box<Map<dynamic, dynamic>>(completedRoutesBoxName);
      final remoteRouteIds = remoteRoutes.map((r) => r.id).toSet();
      final keysToDelete = <dynamic>[];
      for (final key in box.keys) {
        final json = box.get(key);
        if (json != null) {
          final map = Map<String, dynamic>.from(json);
          final routeId = map["routeId"];
          if (routeId != null && !remoteRouteIds.contains(routeId)) {
            keysToDelete.add(key);
          }
        }
      }
      for (final key in keysToDelete) {
        await box.delete(key);
      }
    } catch (_) {
      // If syncing fails, skip it (maybe offline)
    }
    // final localRoutes = await ;
    return _getAllCompletedRoutes();
  }

  Future<void> addCompletedRoute(CompletedRoute route) async {
    final box = Hive.box<Map<dynamic, dynamic>>(completedRoutesBoxName);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await box.add(route.toJson());
      return [...state.value ?? [], route];
    });
  }

  Future<List<CompletedRoute>> _getAllCompletedRoutes() async {
    final box = Hive.box<Map<dynamic, dynamic>>(completedRoutesBoxName);
    return box.values.map((val) => CompletedRoute.fromJson(Map<String, dynamic>.from(val))).toList();
  }

  Map<String, dynamic> getOverviewStats() {
    final routes = state.value ?? [];

    final double sumDistance = routes.fold(0, (sum, route) => sum + route.distance);
    final double sumTime = routes.fold(0, (sum, route) => sum + route.time);
    final int sumCalories = routes.fold(0, (sum, route) => sum + route.calories);
    final int sumWater = routes.fold(0, (sum, route) => sum + route.water);
    final double avgTempo =
        // ignore: prefer_int_literals
        routes.isNotEmpty ? routes.fold(0.0, (sum, route) => sum + route.tempo) / routes.length : 0.0;

    return {
      "sum_distance": sumDistance,
      "sum_time": sumTime,
      "sum_calories": sumCalories,
      "sum_water": sumWater,
      "avg_tempo": avgTempo,
    };
  }
}
