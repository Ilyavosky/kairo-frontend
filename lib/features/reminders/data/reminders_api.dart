import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/api_config.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/api/dio_provider.dart';
import 'package:kairo/features/reminders/data/models/reminder.dart';
import 'package:kairo/features/reminders/data/models/reminder_input.dart';

class RemindersApi {
  const RemindersApi(this._dio);

  static const _path = '${ApiConfig.v1}/recordatorios';
  static const _limit = 200;

  final Dio _dio;

  Future<List<Reminder>> list() {
    return _request(() async {
      final response = await _dio.get<List<dynamic>>(
        _path,
        queryParameters: {'limite': _limit},
      );
      return [
        for (final item in response.data ?? const [])
          Reminder.fromJson(item as Map<String, dynamic>),
      ];
    });
  }

  Future<Reminder> create(ReminderInput input) {
    return _request(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        _path,
        data: input.copyWith(moment: input.moment.toUtc()).toJson(),
      );
      return Reminder.fromJson(response.data ?? const {});
    });
  }

  Future<Reminder> cancel(String reminderId) {
    return _request(() async {
      final response = await _dio.patch<Map<String, dynamic>>(
        '$_path/$reminderId',
        data: {'estado_envio': 'cancelado'},
      );
      return Reminder.fromJson(response.data ?? const {});
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

final remindersApiProvider = Provider<RemindersApi>(
  (ref) => RemindersApi(ref.watch(dioProvider)),
);
