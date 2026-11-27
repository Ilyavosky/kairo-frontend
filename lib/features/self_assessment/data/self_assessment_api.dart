import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/api_config.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/api/dio_provider.dart';
import 'package:kairo/features/self_assessment/data/models/self_assessment.dart';
import 'package:kairo/features/self_assessment/data/models/self_assessment_input.dart';
import 'package:kairo/features/self_assessment/domain/week.dart';

class SelfAssessmentApi {
  const SelfAssessmentApi(this._dio);

  static const _path = '${ApiConfig.v1}/autoevaluaciones';
  static const _limit = 52;

  final Dio _dio;

  Future<List<SelfAssessment>> list() {
    return _request(() async {
      final response = await _dio.get<List<dynamic>>(
        _path,
        queryParameters: {'limite': _limit},
      );
      return [
        for (final item in response.data ?? const [])
          SelfAssessment.fromJson(item as Map<String, dynamic>),
      ];
    });
  }

  Future<SelfAssessment> save(DateTime weekStart, SelfAssessmentInput input) {
    return _request(() async {
      final response = await _dio.put<Map<String, dynamic>>(
        '$_path/${Week.key(weekStart)}',
        data: input.toJson(),
      );
      return SelfAssessment.fromJson(response.data ?? const {});
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

final selfAssessmentApiProvider = Provider<SelfAssessmentApi>(
  (ref) => SelfAssessmentApi(ref.watch(dioProvider)),
);
