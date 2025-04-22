// ignore_for_file: avoid_print, inference_failure_on_function_invocation

import "dart:async";

import "package:dio_cache_interceptor/dio_cache_interceptor.dart";
import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../app/api_base/dio_client.dart";
import "../app/api_base/options.dart";

class TestWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    unawaited(testCache(ref));
    return const SizedBox.shrink();
  }
}

Future<void> testCache(WidgetRef ref) async {
  final dio = await ref.read(dioClientProvider.future);
  const url = "https://jsonplaceholder.typicode.com/posts/1";

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
