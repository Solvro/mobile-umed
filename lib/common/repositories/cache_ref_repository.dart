import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data_source/remote/dio_client.dart";

part "cache_ref_repository.g.dart";

@riverpod
Future<int> fetchCacheNum(Ref ref) async {
  final dio = await ref.read(dioClientProvider.future);
  final response = await dio.get<Map<String, dynamic>>("items/cache_ref");
  final data = response.data!["data"] as Map;
  final cacheNum = data["cache_num"];
  return cacheNum as int;
}
