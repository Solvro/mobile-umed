// ignore_for_file: avoid_print, inference_failure_on_function_invocation

import "dart:async";

import "package:dio_cache_interceptor/dio_cache_interceptor.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:mobile_umed/app/config/env.dart";
import "package:mobile_umed/common/data_source/remote/cache_options.dart";
import "package:mobile_umed/common/data_source/remote/dio_client.dart";

class TestWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    unawaited(testCache(ref));
    return const SizedBox.shrink();
  }
}

Future<void> testCache(WidgetRef ref) async {
  final dio = await ref.read(dioClientProvider.future);
  final url = "${Env.apiUrl}items/routes?fields=*,landmarks.landmarks_id.*,landmarks.landmarks_id.location.*";

  Future<int> measureTime() async {
    final stopwatch = Stopwatch()..start();
    await dio.get(url, options: (await getCacheOptions()).copyWith(maxStale: const Duration(hours: 3)).toOptions());
    stopwatch.stop();
    return stopwatch.elapsedMilliseconds;
  }

  for (int i = 1; i <= 3; i++) {
    print("GET $i   -->   ${await measureTime()} ms");
  }
}

void main() {
  runApp(ProviderScope(child: TestWidget()));
}
