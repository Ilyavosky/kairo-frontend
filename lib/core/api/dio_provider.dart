import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/api_config.dart';
import 'package:kairo/core/api/auth_interceptor.dart';
import 'package:kairo/core/api/error_interceptor.dart';
import 'package:kairo/core/storage/session_controller.dart';
import 'package:kairo/core/storage/token_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);
  final dio =
      Dio(
          BaseOptions(
            baseUrl: ApiConfig.baseUrl,
            connectTimeout: ApiConfig.connectTimeout,
            receiveTimeout: ApiConfig.receiveTimeout,
          ),
        )
        ..interceptors.addAll([
          AuthInterceptor(
            readToken: tokenStorage.readAccessToken,
            onUnauthorized: () =>
                ref.read(sessionControllerProvider.notifier).signOut(),
          ),
          ErrorInterceptor(),
        ]);
  ref.onDispose(dio.close);
  return dio;
});
