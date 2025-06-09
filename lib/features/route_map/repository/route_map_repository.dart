import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../common/data_source/remote/dio_client.dart";
import "../../../common/models/route.dart";

part "route_map_repository.g.dart";

@riverpod
Future<IList<Route>> fetchAllRoutes(Ref ref) async {
  final dio = await ref.read(dioClientProvider.future);
  final response = await dio.get<Map<String, dynamic>>(
    "items/routes?fields=*,landmarks.landmarks_id.*,landmarks.landmarks_id.location.*,landmarks.landmarks_id.type.*,playlist.*,playlist.songs.songs_id.*",
  );
  final data = response.data!["data"] as List<dynamic>;
  return data.map((e) => Route.fromJson(e as Map<String, dynamic>)).toList().lock;
}

@riverpod
Future<Route> fetchRouteWithId(Ref ref, int id) async {
  final dio = await ref.read(dioClientProvider.future);
  final response = await dio.get<Map<String, dynamic>>(
    "items/routes?fields=*,landmarks.landmarks_id.*,landmarks.landmarks_id.location.*,landmarks.landmarks_id.type.*,playlist.*,playlist.songs.songs_id.*&filter[id][_eq]=$id",
  );
  final data = response.data!["data"] as List<dynamic>;
  return Route.fromJson(data[0] as Map<String, dynamic>);
}
