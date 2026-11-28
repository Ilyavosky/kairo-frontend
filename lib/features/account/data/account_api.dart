import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/api_config.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/api/dio_provider.dart';
import 'package:kairo/features/auth/data/models/user_response.dart';

class AccountApi {
  const AccountApi(this._dio);

  final Dio _dio;

  Future<UserResponse> me() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '${ApiConfig.v1}/auth/yo',
      );
      return UserResponse.fromJson(response.data ?? const {});
    } on DioException catch (error) {
      throw toAppException(error);
    }
  }
}

final accountApiProvider = Provider<AccountApi>(
  (ref) => AccountApi(ref.watch(dioProvider)),
);
