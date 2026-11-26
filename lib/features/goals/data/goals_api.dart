import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/api_config.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/api/dio_provider.dart';
import 'package:kairo/features/goals/data/models/goal.dart';
import 'package:kairo/features/goals/data/models/goal_evaluation.dart';
import 'package:kairo/features/goals/data/models/goal_input.dart';
import 'package:kairo/features/goals/data/models/goal_progress.dart';

class GoalsApi {
  const GoalsApi(this._dio);

  static const _path = '${ApiConfig.v1}/metas';
  static const _historyLimit = 200;

  final Dio _dio;

  Future<List<Goal>> list({bool? active}) {
    return _request(() async {
      final response = await _dio.get<List<dynamic>>(
        _path,
        queryParameters: {'activa': ?active},
      );
      return [
        for (final item in response.data ?? const [])
          Goal.fromJson(item as Map<String, dynamic>),
      ];
    });
  }

  Future<Goal> create(GoalInput input) {
    return _request(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        _path,
        data: input.toJson(),
      );
      return Goal.fromJson(response.data ?? const {});
    });
  }

  Future<GoalProgress> progress(String goalId) {
    return _request(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        '$_path/$goalId/progreso',
      );
      return GoalProgress.fromJson(response.data ?? const {});
    });
  }

  Future<List<GoalEvaluation>> history({String? goalId}) {
    return _request(() async {
      final response = await _dio.get<List<dynamic>>(
        '$_path/historial',
        queryParameters: {'limite': _historyLimit, 'meta_id': ?goalId},
      );
      return [
        for (final item in response.data ?? const [])
          GoalEvaluation.fromJson(item as Map<String, dynamic>),
      ];
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

final goalsApiProvider = Provider<GoalsApi>(
  (ref) => GoalsApi(ref.watch(dioProvider)),
);
