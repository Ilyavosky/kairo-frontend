sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => message;
}

final class NetworkException extends AppException {
  const NetworkException()
    : super('Sin conexión. Revisa tu internet e intenta de nuevo.');
}

final class RequestTimeoutException extends AppException {
  const RequestTimeoutException()
    : super('El servidor tardó demasiado en responder. Intenta de nuevo.');
}

final class UnauthorizedException extends AppException {
  const UnauthorizedException([
    super.message = 'Tu sesión expiró. Inicia sesión otra vez.',
  ]);
}

final class NotFoundException extends AppException {
  const NotFoundException() : super('No encontramos lo que buscabas.');
}

final class ValidationException extends AppException {
  const ValidationException([
    super.message = 'Revisa los datos e intenta de nuevo.',
  ]);
}

final class ServiceUnavailableException extends AppException {
  const ServiceUnavailableException([
    super.message =
        'El servicio no está disponible por ahora. Intenta más tarde.',
  ]);
}

final class TooManyRequestsException extends AppException {
  const TooManyRequestsException()
    : super(
        'Hiciste muchas solicitudes seguidas. Espera un momento e intenta '
        'de nuevo.',
      );
}

final class ServerException extends AppException {
  const ServerException()
    : super('Ocurrió un error en el servidor. Intenta más tarde.');
}

final class UnknownException extends AppException {
  const UnknownException() : super('Algo salió mal. Intenta de nuevo.');
}
