import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/api/dio_provider.dart';
import 'package:kairo/features/auth/data/models/login_request.dart';
import 'package:kairo/features/auth/data/models/register_request.dart';
import 'package:kairo/features/auth/data/models/token_response.dart';
import 'package:kairo/features/auth/data/models/user_response.dart';

class AuthApi {
  const AuthApi(this._dio);

  final Dio _dio;

  Future<TokenResponse> login(LoginRequest request) async {
    final data = await _post('/auth/login', request.toJson());
    return TokenResponse.fromJson(data);
  }

  Future<UserResponse> register(RegisterRequest request) async {
    final data = await _post('/auth/registro', request.toJson());
    return UserResponse.fromJson(data);
  }

  Future<Map<String, dynamic>> _post(
    String path,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(path, data: body);
      return response.data ?? const {};
    } on DioException catch (error) {
      throw toAppException(error);
    }
  }
}

final authApiProvider = Provider<AuthApi>(
  (ref) => AuthApi(ref.watch(dioProvider)),
);
