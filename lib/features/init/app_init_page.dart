import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../app/app.dart";
import "../../common/data_source/remote/flush_cache.dart";
import "../../common/providers/storage_service_provider.dart";
import "../../common/repositories/cache_ref_repository.dart";
import "../error/error_page.dart";

class AppInitPage extends ConsumerWidget {
  static const routeName = "/init";

  Future<void> _init(WidgetRef ref, BuildContext context) async {
    final cacheNum = await ref.read(fetchCacheNumProvider.future);
    final cachedCacheNum = ref.read(storageServiceProvider).cacheNum;

    debugPrint("cacheNum: $cacheNum");
    debugPrint("cachedCacheNum: $cachedCacheNum");

    if (cacheNum > cachedCacheNum) {
      await flushHttpCache();
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
