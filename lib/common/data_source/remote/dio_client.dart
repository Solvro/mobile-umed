import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../app/config/env.dart";

part "dio_client.g.dart";

@Riverpod(keepAlive: true)
Dio dioClient(Ref ref) {
  final options = BaseOptions(
    baseUrl: Env.apiUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  );

  return Dio(options);
}
