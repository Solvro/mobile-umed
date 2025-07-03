import "package:hive/hive.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../features/route_map/repository/route_map_repository.dart";
import "../models/completed_route.dart";

part "completed_routes_provider.g.dart";

const String completedRoutesBoxName = "completed_routes";

@riverpod
class CompletedRoutes extends _$CompletedRoutes {
  @override
  Future<List<CompletedRoute>> build() async {
    await Hive.openBox<Map<dynamic, dynamic>>(completedRoutesBoxName);
    final box = Hive.box<Map<dynamic, dynamic>>(completedRoutesBoxName);
    try {
      final remoteRoutes = await ref.read(fetchAllRoutesProvider.future);
      final remoteRouteIds = remoteRoutes.map((r) => r.id).toSet();
      for (final key in _getKeysToDelete(box, remoteRouteIds)) {
        await box.delete(key);
      }
    } on Exception catch (_) {}
    return _getAllCompletedRoutes();
  }

  Future<void> addCompletedRoute(CompletedRoute route) async {
    final box = Hive.box<Map<dynamic, dynamic>>(completedRoutesBoxName);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await box.add(route.toJson());
      return _getAllCompletedRoutes();
    });
  }

  Future<void> resetAllProgress() async {
    final box = Hive.box<Map<dynamic, dynamic>>(completedRoutesBoxName);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await box.clear();
      return _getAllCompletedRoutes();
    });
  }

  Future<List<CompletedRoute>> _getAllCompletedRoutes() async {
    final box = Hive.box<Map<dynamic, dynamic>>(completedRoutesBoxName);
    return box.values.map((val) => CompletedRoute.fromJson(Map<String, dynamic>.from(val))).toList();
  }

  List<dynamic> _getKeysToDelete(Box<Map<dynamic, dynamic>> box, Set<int> remoteRouteIds) {
    final keysToDelete = <dynamic>[];
    for (final key in box.keys) {
      final json = box.get(key);
      if (json != null) {
        final routeId = Map<String, dynamic>.from(json)["routeId"];
        if (routeId != null && !remoteRouteIds.contains(routeId)) {
          keysToDelete.add(key);
        }
      }
    }
    return keysToDelete;
  }
}
