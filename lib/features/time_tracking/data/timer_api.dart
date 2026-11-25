import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/api_config.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/api/dio_provider.dart';
import 'package:kairo/features/time_tracking/data/models/time_record.dart';
import 'package:kairo/features/time_tracking/data/models/timer_session.dart';

class TimerApi {
  const TimerApi(this._dio);

  static const _path = '${ApiConfig.v1}/temporizador';

  final Dio _dio;

  Future<TimerSession?> current() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('$_path/actual');
      return TimerSession.fromJson(response.data ?? const {});
    } on DioException catch (error) {
      if (error.response?.statusCode == 404) {
        return null;
      }
      throw toAppException(error);
    }
  }

  Future<TimerSession> start({
    required String categoryId,
    String? activityId,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '$_path/iniciar',
        data: {'categoria_id': categoryId, 'actividad_id': activityId},
      );
      return TimerSession.fromJson(response.data ?? const {});
    } on DioException catch (error) {
      if (error.response?.statusCode == 409) {
        final running = await current();
        if (running != null) {
          return running;
        }
      }
      throw toAppException(error);
    }
  }

  Future<TimeRecord?> stop({String? note}) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '$_path/detener',
        data: {'nota': note},
      );
      return TimeRecord.fromJson(response.data ?? const {});
    } on DioException catch (error) {
      if (error.response?.statusCode == 404) {
        return null;
      }
      throw toAppException(error);
    }
  }
}

final timerApiProvider = Provider<TimerApi>(
  (ref) => TimerApi(ref.watch(dioProvider)),
);
