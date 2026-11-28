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
    401 => _unauthorized(response?.data),
    404 => const NotFoundException(),
    400 || 409 || 422 => _validation(response?.data),
    429 => const TooManyRequestsException(),
    503 => _unavailable(response?.data),
    >= 500 => const ServerException(),
    _ => const UnknownException(),
  };
}

UnauthorizedException _unauthorized(Object? data) {
  final detalle = _detalle(data);
  return detalle == null
      ? const UnauthorizedException()
      : UnauthorizedException(detalle);
}

ServiceUnavailableException _unavailable(Object? data) {
  final detalle = _detalle(data);
  return detalle == null
      ? const ServiceUnavailableException()
      : ServiceUnavailableException(detalle);
}

ValidationException _validation(Object? data) {
  if (data case {'codigo': 'validacion'}) {
    return const ValidationException();
  }
  final detalle = _detalle(data);
  return detalle == null
      ? const ValidationException()
      : ValidationException(detalle);
}

String? _detalle(Object? data) {
  if (data case {'detalle': final String detalle} when detalle.isNotEmpty) {
    return detalle;
  }
  return null;
}
