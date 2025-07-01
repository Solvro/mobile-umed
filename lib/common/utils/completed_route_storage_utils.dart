import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:hive/hive.dart";
import "../../features/route_map/repository/route_map_repository.dart";
import "../models/completed_route.dart";

const String completedRoutesBoxName = "completed_routes";

Future<void> saveCompletedRoute(CompletedRoute route) async {
  final box = Hive.box<Map<dynamic, dynamic>>(completedRoutesBoxName);
  await box.add(route.toJson());
}

Future<List<CompletedRoute>> getAllCompletedRoutes() async {
  final box = Hive.box<Map<dynamic, dynamic>>(completedRoutesBoxName);
  return box.values.map((val) => CompletedRoute.fromJson(Map<String, dynamic>.from(val))).toList();
}

Future<void> syncLocalWithRemote(WidgetRef ref) async {
  try {
    final remoteRoutes = await ref.read(fetchAllRoutesProvider.future);
    final box = await Hive.openBox<Map<dynamic, dynamic>>(completedRoutesBoxName);
    final remoteRouteIds = remoteRoutes.map((r) => r.id).toSet();

    final keysToDelete = <dynamic>[];
    for (final key in box.keys) {
      final json = box.get(key);
      if (json != null) {
        final routeId = json["routeId"] as int?;
        if (routeId != null && !remoteRouteIds.contains(routeId)) {
          keysToDelete.add(key);
        }
      }
    }
    for (final key in keysToDelete) {
      await box.delete(key);
    }
  } catch (e) {
    //
  }
}
