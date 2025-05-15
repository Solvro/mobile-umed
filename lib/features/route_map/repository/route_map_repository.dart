import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../common/data_source/remote/dio_client.dart";
import "../../../common/models/route.dart";

part "route_map_repository.g.dart";

@riverpod
Future<IList<Route>> fetchAllRoutes(Ref ref) async {
  final box = Hive.box<List<dynamic>>("routesCache");

  if (box.containsKey("allRoutes")) {
    final cachedData = box.get("allRoutes")!;
    return cachedData.map((e) => Route.fromJson(Map<String, dynamic>.from(e as Map))).toList().lock;
  }

  final dio = await ref.read(dioClientProvider.future);
  final response = await dio.get<Map<String, dynamic>>(
    "items/routes?fields=*,landmarks.landmarks_id.*,landmarks.landmarks_id.location.*",
  );
  final data = response.data!["data"] as List<dynamic>;

  await box.put("allRoutes", data);

  return data.map((e) => Route.fromJson(e as Map<String, dynamic>)).toList().lock;
}

@riverpod
Future<Route> fetchRouteWithId(Ref ref, int id) async {
  final box = Hive.box<Map<String, dynamic>>("routesCache");

  if (box.containsKey("route_$id")) {
    final cachedData = box.get("route_$id")!;
    return Route.fromJson(cachedData);
  }

  final dio = await ref.read(dioClientProvider.future);
  final response = await dio.get<Map<String, dynamic>>(
    "items/routes?fields=*,landmarks.landmarks_id.*,landmarks.landmarks_id.location.*&filter[id][_eq]=$id",
  );
  final data = response.data!["data"] as List<dynamic>;

  await box.put("route_$id", data[0] as Map<String, dynamic>);

  return Route.fromJson(data[0] as Map<String, dynamic>);
}
