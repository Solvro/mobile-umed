import "package:dio/dio.dart";
import "package:dio_cache_interceptor/dio_cache_interceptor.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "cache_options.dart";

part "dio_client.g.dart";

@Riverpod(keepAlive: true)
Future<Dio> dioClient(Ref ref) async {
  final dio = Dio();
  dio.interceptors.add(DioCacheInterceptor(options: await getCacheOptions()));
  return dio;
}
