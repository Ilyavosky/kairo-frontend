import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/api/dio_provider.dart';
import 'package:kairo/core/api/models/health_status.dart';

class HealthApi {
  const HealthApi(this._dio);

  final Dio _dio;

  Future<HealthStatus> check() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/health');
      return HealthStatus.fromJson(response.data ?? const {});
    } on DioException catch (error) {
      throw toAppException(error);
    }
  }
}

final healthApiProvider = Provider<HealthApi>(
  (ref) => HealthApi(ref.watch(dioProvider)),
);

final healthStatusProvider = FutureProvider<HealthStatus>(
  (ref) => ref.watch(healthApiProvider).check(),
);
