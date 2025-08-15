import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_foreground_task/flutter_foreground_task.dart";
import "package:flutter_native_splash/flutter_native_splash.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:hive/hive.dart";
import "package:path_provider/path_provider.dart";
import "package:sentry_flutter/sentry_flutter.dart";
import "app/app.dart";
import "app/config/cached_image_config.dart";
import "app/config/env.dart";
import "app/wiredash.dart";
import "common/data_source/remote/cache_options.dart";
import "common/repositories/cache_ref_repository.dart";
import "common/utils/storage_service.dart";

void main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await StorageService.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  FlutterForegroundTask.initCommunicationPort();

  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  final container = ProviderContainer();
  try {
    final cachedCacheNum = StorageService.cacheNum;
    final cacheNum = await container.read(fetchCacheNumProvider.future);

    if (cacheNum > cachedCacheNum) {
      await clearDioCache();
      await CachedImageConfig.cacheManagerInstance.emptyCache();
      await StorageService.setCacheNum(cacheNum);
    }
  } finally {
    FlutterNativeSplash.remove();
  }

  if (!kReleaseMode) {
    runApp(const ProviderScope(child: ProdWiredash(child: WithForegroundTask(child: MyApp()))));
  } else {
    await SentryFlutter.init(
      (options) {
        options.dsn = Env.bugsinkDsn;
        options.sendDefaultPii = true;
        options.tracesSampleRate = 0;
      },
      appRunner: () {
        runApp(const ProviderScope(child: ProdWiredash(child: WithForegroundTask(child: MyApp()))));
      },
    );
  }
}
