import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../features/map/route_map/repository/route_map_repository.dart";
import "completed_routes_provider.dart";

part "progress_provider.g.dart";

@riverpod
Future<double> routeProgress(Ref ref) async {
  final routes = await ref.watch(fetchAllRoutesProvider.future);
  final completedRoutes = await ref.watch(completedRoutesProvider.future);

  if (routes.isEmpty) return 0.0;

  return completedRoutes.length / routes.length;
}
