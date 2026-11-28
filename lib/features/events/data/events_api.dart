import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/api_config.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/api/dio_provider.dart';
import 'package:kairo/features/events/data/models/event.dart';
import 'package:kairo/features/events/data/models/event_input.dart';
import 'package:kairo/features/events/domain/event_type.dart';

class EventsApi {
  const EventsApi(this._dio);

  static const _path = '${ApiConfig.v1}/eventos';
  static const _limit = 200;

  final Dio _dio;

  Future<List<Event>> list({
    DateTime? from,
    DateTime? to,
    EventType? type,
  }) async {
    try {
      final response = await _dio.get<List<dynamic>>(
        _path,
        queryParameters: {
          'limite': _limit,
          'desde': ?from?.toUtc().toIso8601String(),
          'hasta': ?to?.toUtc().toIso8601String(),
          'tipo': ?type?.apiValue,
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

  Future<Event> get(String eventId) =>
      _one(() => _dio.get<Map<String, dynamic>>('$_path/$eventId'));

  Future<Event> create(EventInput input) =>
      _one(() => _dio.post<Map<String, dynamic>>(_path, data: _body(input)));

  Future<Event> update(String eventId, EventInput input) => _one(
    () =>
        _dio.patch<Map<String, dynamic>>('$_path/$eventId', data: _body(input)),
  );

  Map<String, dynamic> _body(EventInput input) => input
      .copyWith(start: input.start.toUtc(), end: input.end.toUtc())
      .toJson();

  Future<Event> _one(
    Future<Response<Map<String, dynamic>>> Function() call,
  ) async {
    try {
      final response = await call();
      return Event.fromJson(response.data ?? const {});
    } on DioException catch (error) {
      throw toAppException(error);
    }
  }
}

final eventsApiProvider = Provider<EventsApi>(
  (ref) => EventsApi(ref.watch(dioProvider)),
);
