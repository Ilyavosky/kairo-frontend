import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/api/dio_provider.dart';
import 'package:kairo/features/subjects/data/models/subject.dart';
import 'package:kairo/features/subjects/data/models/subject_input.dart';

class SubjectsApi {
  const SubjectsApi(this._dio);

  static const _path = '/materias';

  final Dio _dio;

  Future<List<Subject>> listActive() {
    return _request(() async {
      final response = await _dio.get<List<dynamic>>(
        _path,
        queryParameters: {'activa': true},
      );
      return [
        for (final item in response.data ?? const [])
          Subject.fromJson(item as Map<String, dynamic>),
      ];
    });
  }

  Future<Subject> get(String id) {
    return _request(() async {
      final response = await _dio.get<Map<String, dynamic>>('$_path/$id');
      return Subject.fromJson(response.data ?? const {});
    });
  }

  Future<Subject> create(SubjectInput input) {
    return _request(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        _path,
        data: input.toJson(),
      );
      return Subject.fromJson(response.data ?? const {});
    });
  }

  Future<Subject> update(String id, SubjectInput input) {
    return _patch(id, input.toJson());
  }

  Future<Subject> archive(String id) {
    return _patch(id, {'activa': false});
  }

  Future<Subject> _patch(String id, Map<String, dynamic> body) {
    return _request(() async {
      final response = await _dio.patch<Map<String, dynamic>>(
        '$_path/$id',
        data: body,
      );
      return Subject.fromJson(response.data ?? const {});
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

final subjectsApiProvider = Provider<SubjectsApi>(
  (ref) => SubjectsApi(ref.watch(dioProvider)),
);

final subjectsProvider = FutureProvider<List<Subject>>(
  (ref) => ref.watch(subjectsApiProvider).listActive(),
);
