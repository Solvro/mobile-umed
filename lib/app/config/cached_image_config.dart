import "package:flutter_cache_manager/flutter_cache_manager.dart";

abstract class CachedImageConfig {
  static const cacheKey = "umed_image_cache";
  static final cacheConfig = Config(cacheKey, stalePeriod: const Duration(days: 7));
}
