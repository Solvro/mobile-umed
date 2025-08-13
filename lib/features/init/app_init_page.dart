import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../app/app.dart";
import "../../app/config/cached_image_config.dart";
import "../../common/data_source/remote/cache_options.dart";
import "../../common/repositories/cache_ref_repository.dart";
import "../../common/utils/storage_service.dart";
import "../error/views/full_screen_error_view.dart";

class AppInitPage extends ConsumerWidget {
  const AppInitPage({super.key});
  static const routeName = "/init";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("init");
    ref.listen(cacheInitProvider, (prev, status) {
      if (status is AsyncData) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) context.router.goHome();
        });
      }
    });

    final cacheInitProviderAsync = ref.watch(cacheInitProvider);

    return switch (cacheInitProviderAsync) {
      (AsyncData()) => const SizedBox.shrink(),
      AsyncError(:final error, :final stackTrace) => FullScreenErrorView(
        message: kDebugMode ? "$error\n$stackTrace" : null,
      ),
      AsyncLoading() => const CircularProgressIndicator(),
      _ => const SizedBox.shrink(),
    };
  }
}

final cacheInitProvider = FutureProvider((ref) async {
  final storageService = await ref.read(storageServiceProvider.future);
  final cachedCacheNum = storageService.cacheNum;

  final cacheNum = await ref.read(fetchCacheNumProvider.future);

  if (cacheNum > cachedCacheNum) {
    await clearDioCache();
    await CachedImageConfig.cacheManagerInstance.emptyCache();
    await storageService.setCacheNum(cacheNum);
  }
});
