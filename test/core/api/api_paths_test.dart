import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/core/api/health_api.dart';
import 'package:kairo/features/auth/data/auth_api.dart';
import 'package:kairo/features/auth/data/models/login_request.dart';
import 'package:kairo/features/auth/data/models/register_request.dart';
import 'package:kairo/features/subjects/data/models/subject_input.dart';
import 'package:kairo/features/subjects/data/subjects_api.dart';

class _RecordingAdapter implements HttpClientAdapter {
  _RecordingAdapter(this.body);

  final Object body;
  final List<RequestOptions> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return ResponseBody.fromString(
      jsonEncode(body),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  const subjectJson = {
    'id': 'materia-1',
    'nombre': 'Seguridad informática',
    'periodo': 'Ago - Dic 2026',
    'activa': true,
    'docente': null,
    'clave': null,
  };

  Dio dioWith(_RecordingAdapter adapter) =>
      Dio(BaseOptions(baseUrl: 'https://kairo.test'))
        ..httpClientAdapter = adapter;

  test('la salud del servidor se consulta en /health', () async {
    final adapter = _RecordingAdapter({'status': 'healthy'});

    await HealthApi(dioWith(adapter)).check();

    expect(adapter.requests.single.uri.path, '/health');
  });

  test('el login y el registro van bajo /api/v1/auth', () async {
    final adapter = _RecordingAdapter({
      'access_token': 'token',
      'id': 'usuario-1',
      'email': 'aurora@correo.com',
      'nombre': 'Aurora',
      'zona_horaria': 'America/Mexico_City',
      'fecha_registro': '2026-11-20T12:00:00Z',
      'activo': true,
      'telegram_id': null,
    });
    final api = AuthApi(dioWith(adapter));

    await api.login(
      const LoginRequest(email: 'aurora@correo.com', password: '12345678'),
    );
    await api.register(
      const RegisterRequest(
        name: 'Aurora',
        email: 'aurora@correo.com',
        password: '12345678',
        timezone: 'America/Mexico_City',
      ),
    );

    expect(adapter.requests.map((request) => request.uri.path), [
      '/api/v1/auth/login',
      '/api/v1/auth/registro',
    ]);
    expect(adapter.requests.last.data, {
      'nombre': 'Aurora',
      'email': 'aurora@correo.com',
      'password': '12345678',
      'zona_horaria': 'America/Mexico_City',
    });
  });

  test('las materias van bajo /api/v1/materias', () async {
    final listAdapter = _RecordingAdapter([subjectJson]);
    await SubjectsApi(dioWith(listAdapter)).listActive();

    final request = listAdapter.requests.single;
    expect(request.uri.path, '/api/v1/materias');
    expect(request.uri.queryParameters['activa'], 'true');

    final adapter = _RecordingAdapter(subjectJson);
    final api = SubjectsApi(dioWith(adapter));
    await api.create(
      const SubjectInput(
        name: 'Seguridad informática',
        period: 'Ago - Dic 2026',
      ),
    );
    await api.archive('materia-1');

    expect(adapter.requests.first.uri.path, '/api/v1/materias');
    expect(adapter.requests.last.uri.path, '/api/v1/materias/materia-1');
    expect(adapter.requests.last.data, {'activa': false});
  });
}
