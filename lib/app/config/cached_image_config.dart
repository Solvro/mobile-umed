import "package:flutter_cache_manager/flutter_cache_manager.dart";

import "env.dart";

abstract class CachedImageConfig {
  static const cacheKey = "umed_image_cache";
  static final cacheManagerInstance = CacheManager(Config(cacheKey, stalePeriod: const Duration(days: 7)));

  static String? getDirectusUrl(String? assetId) => assetId != null ? "${Env.apiUrl}assets/$assetId" : null;
}
