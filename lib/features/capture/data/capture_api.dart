import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/api_config.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/api/dio_provider.dart';
import 'package:kairo/features/capture/data/models/capture.dart';

class CaptureApi {
  const CaptureApi(this._dio);

  static const _path = '${ApiConfig.v1}/capturas';

  final Dio _dio;

  Future<Capture> create(String text) => _post(_path, data: {'texto': text});

  Future<Capture> confirm(String id) => _post('$_path/$id/confirmar');

  Future<Capture> correct(String id, Map<String, dynamic> fields) =>
      _post('$_path/$id/corregir', data: {'campos': fields});

  Future<Capture> discard(String id) => _post('$_path/$id/descartar');

  Future<Capture> _post(String path, {Object? data}) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(path, data: data);
      return Capture.fromJson(response.data ?? const {});
    } on DioException catch (error) {
      throw toAppException(error);
    }
  }
}

final captureApiProvider = Provider<CaptureApi>(
  (ref) => CaptureApi(ref.watch(dioProvider)),
);
