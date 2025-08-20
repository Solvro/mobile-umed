import "dart:async";

import "package:dio_cache_interceptor/dio_cache_interceptor.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:http_cache_hive_store/http_cache_hive_store.dart";
import "package:path_provider/path_provider.dart";

final errorCodes = [
  400,
  401,
  402,
  403,
  404,
  405,
  406,
  407,
  408,
  409,
  410,
  411,
  412,
  413,
  414,
  415,
  416,
  417,
  418,
  421,
  422,
  423,
  424,
  425,
  426,
  428,
  429,
  431,
  451,
  500,
  501,
  502,
  503,
  504,
  505,
  506,
  507,
  508,
  510,
  511,
];

HiveCacheStore? _cacheStore;

CacheOptions getNoCacheOptions() {
  return CacheOptions(store: MemCacheStore(), policy: CachePolicy.noCache);
}

Future<void> _initCacheStore() async {
  final dir = await getApplicationSupportDirectory();
  await Hive.initFlutter(dir.path);
  _cacheStore = HiveCacheStore(dir.path);
}

Future<CacheOptions> getCacheOptions() async {
  if (_cacheStore == null) {
    await _initCacheStore();
  }

  return CacheOptions(
    store: _cacheStore,
    policy: CachePolicy.forceCache,
    hitCacheOnErrorCodes: errorCodes,
    hitCacheOnNetworkFailure: true,
    maxStale: const Duration(days: 7),
  );
}

Future<void> clearDioCache() async {
  await _initCacheStore();
  await _cacheStore?.clean();
}
