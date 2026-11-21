import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/errors/app_exception.dart';

void main() {
  final requestOptions = RequestOptions(path: '/materias');

  DioException exceptionOfType(DioExceptionType type) =>
      DioException(requestOptions: requestOptions, type: type);

  DioException badResponse(int statusCode, [Object? data]) => DioException(
    requestOptions: requestOptions,
    type: DioExceptionType.badResponse,
    response: Response<Object?>(
      requestOptions: requestOptions,
      statusCode: statusCode,
      data: data,
    ),
  );

  group('mapDioException', () {
    test('convierte un timeout en RequestTimeoutException', () {
      final result = mapDioException(
        exceptionOfType(DioExceptionType.receiveTimeout),
      );

      expect(result, isA<RequestTimeoutException>());
    });

    test('convierte un error de conexión en NetworkException', () {
      final result = mapDioException(
        exceptionOfType(DioExceptionType.connectionError),
      );

      expect(result, isA<NetworkException>());
    });

    test('convierte un 401 en UnauthorizedException', () {
      expect(mapDioException(badResponse(401)), isA<UnauthorizedException>());
    });

    test('usa el detalle del servidor en un 401', () {
      final result = mapDioException(
        badResponse(401, {
          'codigo': 'credenciales_invalidas',
          'detalle': 'Correo o contraseña incorrectos',
        }),
      );

      expect(result, isA<UnauthorizedException>());
      expect(result.message, 'Correo o contraseña incorrectos');
    });

    test('usa el detalle del servidor en errores de validación', () {
      final result = mapDioException(
        badResponse(409, {
          'codigo': 'conflicto',
          'detalle': 'La materia ya existe',
        }),
      );

      expect(result, isA<ValidationException>());
      expect(result.message, 'La materia ya existe');
    });

    test('usa un mensaje genérico si el detalle viene vacío', () {
      final result = mapDioException(
        badResponse(422, {'codigo': 'validacion', 'detalle': ''}),
      );

      expect(result, isA<ValidationException>());
      expect(result.message, 'Revisa los datos e intenta de nuevo.');
    });

    test('convierte un 500 en ServerException', () {
      expect(mapDioException(badResponse(500)), isA<ServerException>());
    });

    test('convierte una cancelación en UnknownException', () {
      final result = mapDioException(exceptionOfType(DioExceptionType.cancel));

      expect(result, isA<UnknownException>());
    });
  });

  group('toAppException', () {
    test('devuelve el AppException que ya trae el error de dio', () {
      final exception = DioException(
        requestOptions: requestOptions,
        error: const NotFoundException(),
      );

      expect(toAppException(exception), isA<NotFoundException>());
    });

    test('convierte errores desconocidos en UnknownException', () {
      expect(toAppException(StateError('x')), isA<UnknownException>());
    });
  });
}
