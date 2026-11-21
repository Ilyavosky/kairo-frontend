import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/api_config.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/api/dio_provider.dart';
import 'package:kairo/features/home/data/models/calendar_event.dart';

class CalendarApi {
  const CalendarApi(this._dio);

  static const _path = '${ApiConfig.v1}/calendario';

  final Dio _dio;

  Future<List<CalendarEvent>> list() async {
    try {
      final response = await _dio.get<List<dynamic>>(_path);
      return [
        for (final item in response.data ?? const [])
          CalendarEvent.fromJson(item as Map<String, dynamic>),
      ];
    } on DioException catch (error) {
      throw toAppException(error);
    }
  }
}

final calendarApiProvider = Provider<CalendarApi>(
  (ref) => CalendarApi(ref.watch(dioProvider)),
);
