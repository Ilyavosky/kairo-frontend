import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/api_config.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/api/dio_provider.dart';
import 'package:kairo/features/events/data/models/event.dart';

class EventsApi {
  const EventsApi(this._dio);

  static const _path = '${ApiConfig.v1}/eventos';
  static const _limit = 200;

  final Dio _dio;

  Future<List<Event>> list({DateTime? from}) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        _path,
        queryParameters: {
          'limite': _limit,
          'desde': ?from?.toUtc().toIso8601String(),
        },
      );
      return [
        for (final item in response.data ?? const [])
          Event.fromJson(item as Map<String, dynamic>),
      ];
    } on DioException catch (error) {
      throw toAppException(error);
    }
  }
}

final eventsApiProvider = Provider<EventsApi>(
  (ref) => EventsApi(ref.watch(dioProvider)),
);
