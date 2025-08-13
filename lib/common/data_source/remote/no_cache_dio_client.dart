import "package:dio/dio.dart";
import "package:dio_cache_interceptor/dio_cache_interceptor.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../app/config/env.dart";
import "cache_options.dart";

part "no_cache_dio_client.g.dart";

@Riverpod(keepAlive: true)
Future<Dio> noCacheDioClient(Ref ref) async {
  final options = BaseOptions(
    baseUrl: Env.apiUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 8),
  );

  final dio = Dio(options);

  dio.interceptors.add(DioCacheInterceptor(options: getNoCacheOptions()));

  return dio;
}
