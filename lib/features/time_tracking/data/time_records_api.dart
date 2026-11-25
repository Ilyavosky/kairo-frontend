import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/api_config.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/api/dio_provider.dart';
import 'package:kairo/features/time_tracking/data/models/time_record.dart';
import 'package:kairo/features/time_tracking/data/models/time_record_input.dart';

class TimeRecordsApi {
  const TimeRecordsApi(this._dio);

  static const _path = '${ApiConfig.v1}/registros-tiempo';
  static const _pageSize = 200;

  final Dio _dio;

  Future<List<TimeRecord>> list() {
    return _request(() async {
      final response = await _dio.get<List<dynamic>>(
        _path,
        queryParameters: {'limite': _pageSize},
      );
      return [
        for (final item in response.data ?? const [])
          TimeRecord.fromJson(item as Map<String, dynamic>),
      ];
    });
  }

  Future<TimeRecord> create(TimeRecordInput input) {
    return _request(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        _path,
        data: input.toJson(),
      );
      return TimeRecord.fromJson(response.data ?? const {});
    });
  }

  Future<TimeRecord> update(String id, TimeRecordInput input) {
    return _request(() async {
      final response = await _dio.patch<Map<String, dynamic>>(
        '$_path/$id',
        data: input.toJson(),
      );
      return TimeRecord.fromJson(response.data ?? const {});
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

final timeRecordsApiProvider = Provider<TimeRecordsApi>(
  (ref) => TimeRecordsApi(ref.watch(dioProvider)),
);

final timeRecordsProvider = FutureProvider<List<TimeRecord>>(
  (ref) => ref.watch(timeRecordsApiProvider).list(),
);
