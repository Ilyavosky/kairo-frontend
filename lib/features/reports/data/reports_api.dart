import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/api_config.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/api/dio_provider.dart';
import 'package:kairo/features/reports/data/models/goal_report.dart';
import 'package:kairo/features/reports/data/models/report_summary.dart';
import 'package:kairo/features/reports/data/models/rest_week.dart';
import 'package:kairo/features/reports/data/models/weekly_load.dart';

class ReportsApi {
  const ReportsApi(this._dio);

  static const _path = '${ApiConfig.v1}/reportes';
  static const weeksBack = 8;
  static const weeksAhead = 4;

  final Dio _dio;

  Future<List<WeeklyLoad>> weeklyLoad() => _list('$_path/carga-semanal', {
    'semanas_atras': weeksBack,
    'semanas_adelante': weeksAhead,
  }, WeeklyLoad.fromJson);

  Future<List<RestWeek>> loadVsRest() => _list('$_path/carga-vs-descanso', {
    'semanas': weeksBack,
  }, RestWeek.fromJson);

  Future<List<GoalReport>> goals() =>
      _list('$_path/metas', const {}, GoalReport.fromJson);

  Future<ReportSummary> summary() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('$_path/resumen');
      return ReportSummary.fromJson(response.data ?? const {});
    } on DioException catch (error) {
      throw toAppException(error);
    }
  }

  Future<List<T>> _list<T>(
    String path,
    Map<String, dynamic> query,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        path,
        queryParameters: query,
      );
      return [
        for (final item in response.data ?? const [])
          fromJson(item as Map<String, dynamic>),
      ];
    } on DioException catch (error) {
      throw toAppException(error);
    }
  }
}

final reportsApiProvider = Provider<ReportsApi>(
  (ref) => ReportsApi(ref.watch(dioProvider)),
);
