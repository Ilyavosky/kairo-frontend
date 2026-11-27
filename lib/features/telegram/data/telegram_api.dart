import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/api_config.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/api/dio_provider.dart';
import 'package:kairo/features/auth/data/models/user_response.dart';
import 'package:kairo/features/telegram/data/models/telegram_link.dart';

class TelegramApi {
  const TelegramApi(this._dio);

  final Dio _dio;

  Future<bool> isLinked() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '${ApiConfig.v1}/auth/yo',
      );
      final user = UserResponse.fromJson(response.data ?? const {});
      return user.telegramId != null;
    } on DioException catch (error) {
      throw toAppException(error);
    }
  }

  Future<TelegramLink> createLink() async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '${ApiConfig.v1}/telegram/vinculo',
      );
      return TelegramLink.fromJson(response.data ?? const {});
    } on DioException catch (error) {
      throw toAppException(error);
    }
  }
}

final telegramApiProvider = Provider<TelegramApi>(
  (ref) => TelegramApi(ref.watch(dioProvider)),
);
