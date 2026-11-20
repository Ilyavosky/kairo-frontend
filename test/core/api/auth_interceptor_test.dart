import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/core/api/auth_interceptor.dart';

class _RequestHandler extends RequestInterceptorHandler {
  RequestOptions? forwarded;

  @override
  void next(RequestOptions requestOptions) => forwarded = requestOptions;
}

class _ErrorHandler extends ErrorInterceptorHandler {
  DioException? forwarded;

  @override
  void next(DioException error) => forwarded = error;
}

void main() {
  var unauthorizedCalls = 0;

  AuthInterceptor interceptorWith(String? token) => AuthInterceptor(
    readToken: () async => token,
    onUnauthorized: () async {
      unauthorizedCalls++;
    },
  );

  DioException unauthorized(Map<String, dynamic> headers) {
    final options = RequestOptions(path: '/auth/yo', headers: headers);
    return DioException(
      requestOptions: options,
      type: DioExceptionType.badResponse,
      response: Response<Object?>(requestOptions: options, statusCode: 401),
    );
  }

  setUp(() => unauthorizedCalls = 0);

  test('agrega el token Bearer cuando hay sesión', () async {
    final handler = _RequestHandler();

    await interceptorWith('abc')
        .onRequest(RequestOptions(path: '/auth/yo'), handler);

    expect(handler.forwarded?.headers['Authorization'], 'Bearer abc');
  });

  test('no agrega encabezado cuando no hay sesión', () async {
    final handler = _RequestHandler();

    await interceptorWith(null)
        .onRequest(RequestOptions(path: '/health'), handler);

    expect(handler.forwarded?.headers.containsKey('Authorization'), isFalse);
  });

  test('cierra la sesión ante un 401 de una petición con token', () async {
    final handler = _ErrorHandler();

    await interceptorWith('abc')
        .onError(unauthorized({'Authorization': 'Bearer abc'}), handler);

    expect(unauthorizedCalls, 1);
    expect(handler.forwarded, isNotNull);
  });

  test('no cierra sesión ante un 401 sin token', () async {
    final handler = _ErrorHandler();

    await interceptorWith(null).onError(unauthorized({}), handler);

    expect(unauthorizedCalls, 0);
  });
}
