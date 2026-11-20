import 'package:dio/dio.dart';
import 'package:kairo/core/errors/app_exception.dart';

AppException toAppException(Object error) {
  return switch (error) {
    AppException() => error,
    DioException(error: final AppException mapped) => mapped,
    DioException() => mapDioException(error),
    _ => const UnknownException(),
  };
}

AppException mapDioException(DioException exception) {
  return switch (exception.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout => const RequestTimeoutException(),
    DioExceptionType.connectionError => const NetworkException(),
    DioExceptionType.badResponse => _fromResponse(exception.response),
    _ => const UnknownException(),
  };
}

AppException _fromResponse(Response<dynamic>? response) {
  final statusCode = response?.statusCode ?? 0;

  return switch (statusCode) {
    401 => const UnauthorizedException(),
    404 => const NotFoundException(),
    400 || 409 || 422 => _validation(response?.data),
    >= 500 => const ServerException(),
    _ => const UnknownException(),
  };
}

ValidationException _validation(Object? data) {
  if (data case {'detalle': final String detalle} when detalle.isNotEmpty) {
    return ValidationException(detalle);
  }
  return const ValidationException();
}
