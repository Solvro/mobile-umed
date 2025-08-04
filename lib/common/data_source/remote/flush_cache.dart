import "package:flutter/foundation.dart";
import "package:http_cache_hive_store/http_cache_hive_store.dart";
import "package:path_provider/path_provider.dart";

Future<void> flushHttpCache() async {
  final dir = await getApplicationSupportDirectory();
  final store = HiveCacheStore(dir.path);
  debugPrint("Cleaning");
  await store.clean();
  debugPrint("Cleaned");
}
