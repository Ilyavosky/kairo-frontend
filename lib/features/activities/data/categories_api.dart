import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/api_config.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/api/dio_provider.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';

class CategoriesApi {
  const CategoriesApi(this._dio);

  static const _path = '${ApiConfig.v1}/categorias';

  final Dio _dio;

  Future<List<ActivityCategory>> list() async {
    try {
      final response = await _dio.get<List<dynamic>>(_path);
      return [
        for (final item in response.data ?? const [])
          ActivityCategory.fromJson(item as Map<String, dynamic>),
      ];
    } on DioException catch (error) {
      throw toAppException(error);
    }
  }
}

final categoriesApiProvider = Provider<CategoriesApi>(
  (ref) => CategoriesApi(ref.watch(dioProvider)),
);

final categoriesProvider = FutureProvider<List<ActivityCategory>>(
  (ref) => ref.watch(categoriesApiProvider).list(),
);
