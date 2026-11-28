import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/api_config.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/api/dio_provider.dart';
import 'package:kairo/features/tags/data/models/tag.dart';

class TagsApi {
  const TagsApi(this._dio);

  static const _tags = '${ApiConfig.v1}/etiquetas';
  static const _activities = '${ApiConfig.v1}/actividades';

  final Dio _dio;

  Future<List<Tag>> list() => _list(_tags);

  Future<List<Tag>> ofActivity(String activityId) =>
      _list('$_activities/$activityId/etiquetas');

  Future<Tag> create(String name) {
    return _request(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        _tags,
        data: {'nombre': name},
      );
      return Tag.fromJson(response.data ?? const {});
    });
  }

  Future<void> assign(String activityId, String tagId) => _request(
    () => _dio.put<void>('$_activities/$activityId/etiquetas/$tagId'),
  );

  Future<void> remove(String activityId, String tagId) => _request(
    () => _dio.delete<void>('$_activities/$activityId/etiquetas/$tagId'),
  );

  Future<List<Tag>> _list(String path) {
    return _request(() async {
      final response = await _dio.get<List<dynamic>>(path);
      return [
        for (final item in response.data ?? const [])
          Tag.fromJson(item as Map<String, dynamic>),
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

final tagsApiProvider = Provider<TagsApi>(
  (ref) => TagsApi(ref.watch(dioProvider)),
);
