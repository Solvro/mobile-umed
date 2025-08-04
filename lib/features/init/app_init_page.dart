import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../app/app.dart";
import "../../app/config/cached_image_config.dart";
import "../../common/repositories/cache_ref_repository.dart";
import "../../common/utils/storage_service.dart";
import "../error/error_page.dart";

class AppInitPage extends ConsumerWidget {
  static const routeName = "/init";

  Future<void> _init(WidgetRef ref, BuildContext context) async {
    final cacheNum = await ref.read(fetchCacheNumProvider.future);
    final cachedCacheNum = ref.read(storageServiceProvider).cacheNum;

    if (cacheNum > cachedCacheNum) {
      await CachedImageConfig.cacheManagerInstance.emptyCache();
      await ref.read(storageServiceProvider).setCacheNum(cacheNum);
    }

    if (context.mounted) {
      context.router.goHome();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<void>(
      future: _init(ref, context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return ErrorPage(onBackToHome: context.router.goHome, message: snapshot.error.toString());
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
