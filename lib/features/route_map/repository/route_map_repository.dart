import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../app/config/env.dart";
import "../../../common/data_source/remote/dio_client.dart";

part "route_map_repository.g.dart";

@riverpod
Future<Map<String, dynamic>> fetchAllRoutes(Ref ref) async {
  final dio = ref.watch(dioClientProvider);
  final response = await dio.get<Map<String, dynamic>>(
    "${Env.apiUrl}items/routes?fields=*,landmarks.landmarks_id.*,landmarks.landmarks_id.location.*",
  );

  if (response.statusCode == 200) {
    return response.data!;
  } else {
    throw Exception("Failed to load routes");
  }
}

@riverpod
Future<Map<String, dynamic>> fetchRouteWithId(Ref ref, int id) async {
  final dio = ref.watch(dioClientProvider);
  final response = await dio.get<Map<String, dynamic>>(
    "${Env.apiUrl}items/routes?fields=*,landmarks.landmarks_id.*,landmarks.landmarks_id.location.*&filter[id][_eq]=$id",
  );

  if (response.statusCode == 200) {
    return response.data!;
  } else {
    throw Exception("Failed to load route with id $id");
  }
}
