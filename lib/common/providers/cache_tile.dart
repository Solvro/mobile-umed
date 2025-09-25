import "package:flutter_map_cache/flutter_map_cache.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:http_cache_hive_store/http_cache_hive_store.dart";
import "package:path_provider/path_provider.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "cache_tile.g.dart";

@Riverpod(keepAlive: true)
Future<CachedTileProvider> cacheTile(Ref ref) async {
  final cacheDirectory = await getTemporaryDirectory();
  final path = cacheDirectory.path;
  return CachedTileProvider(
    maxStale: const Duration(days: 90),
    store: HiveCacheStore(path, hiveBoxName: "HiveCacheStore"),
  );
}
