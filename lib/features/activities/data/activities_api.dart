import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/api_config.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/api/dio_provider.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/domain/activity_filter.dart';
import 'package:kairo/features/activities/domain/activity_status.dart';

class ActivitiesApi {
  const ActivitiesApi(this._dio);

  static const _path = '${ApiConfig.v1}/actividades';
  static const _pageSize = 200;

  final Dio _dio;

  Future<List<Activity>> list(ActivityFilter filter) {
    return _request(() async {
      final response = await _dio.get<List<dynamic>>(
        _path,
        queryParameters: {
          'limite': _pageSize,
          if (filter.status != null) 'estado': filter.status!.apiValue,
          if (filter.subjectId != null) 'materia_id': filter.subjectId,
        },
      );
      return [
        for (final item in response.data ?? const [])
          Activity.fromJson(item as Map<String, dynamic>),
      ];
    });
  }

  Future<Activity> complete(String id) {
    return _request(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        '$_path/$id/completar',
      );
      return Activity.fromJson(response.data ?? const {});
    });
  }

  Future<Activity> reopen(String id) {
    return _request(() async {
      final response = await _dio.patch<Map<String, dynamic>>(
        '$_path/$id',
        data: {'estado': ActivityStatus.pending.apiValue},
      );
      return Activity.fromJson(response.data ?? const {});
    });
  }

  Future<T> _request<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on DioException catch (error) {
      throw toAppException(error);
    }
  }
}

final activitiesApiProvider = Provider<ActivitiesApi>(
  (ref) => ActivitiesApi(ref.watch(dioProvider)),
);
