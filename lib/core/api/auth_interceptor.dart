import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.readToken, required this.onUnauthorized});

  static const authorizationHeader = 'Authorization';

  final Future<String?> Function() readToken;
  final Future<void> Function() onUnauthorized;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await readToken();
    if (token != null && token.isNotEmpty) {
      options.headers[authorizationHeader] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final sentToken = err.requestOptions.headers.containsKey(
      authorizationHeader,
    );
    if (err.response?.statusCode == 401 && sentToken) {
      await onUnauthorized();
    }
    handler.next(err);
  }
}
