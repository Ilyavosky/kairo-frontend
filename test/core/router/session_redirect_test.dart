import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/core/router/app_routes.dart';
import 'package:kairo/core/router/app_section.dart';
import 'package:kairo/core/router/session_redirect.dart';

void main() {
  group('sessionRedirect', () {
    test('mientras carga la sesión manda a la pantalla de carga', () {
      expect(
        sessionRedirect(
          session: const AsyncLoading(),
          location: AppSection.goals.path,
        ),
        AppRoutes.splash,
      );
      expect(
        sessionRedirect(
          session: const AsyncLoading(),
          location: AppRoutes.splash,
        ),
        isNull,
      );
    });

    test('sin sesión manda al inicio de sesión', () {
      expect(
        sessionRedirect(
          session: const AsyncData(false),
          location: AppSection.home.path,
        ),
        AppRoutes.login,
      );
      expect(
        sessionRedirect(
          session: const AsyncData(false),
          location: AppRoutes.login,
        ),
        isNull,
      );
    });

    test('sin sesión deja abrir la pantalla de crear cuenta', () {
      expect(
        sessionRedirect(
          session: const AsyncData(false),
          location: AppRoutes.register,
        ),
        isNull,
      );
    });

    test('con sesión saca de la pantalla de crear cuenta', () {
      expect(
        sessionRedirect(
          session: const AsyncData(true),
          location: AppRoutes.register,
        ),
        AppSection.home.path,
      );
    });

    test('si falla la lectura de la sesión manda al inicio de sesión', () {
      expect(
        sessionRedirect(
          session: AsyncError<bool>(Exception(), StackTrace.empty),
          location: AppSection.home.path,
        ),
        AppRoutes.login,
      );
    });

    test('con sesión saca de las rutas públicas y deja pasar al resto', () {
      expect(
        sessionRedirect(
          session: const AsyncData(true),
          location: AppRoutes.login,
        ),
        AppSection.home.path,
      );
      expect(
        sessionRedirect(
          session: const AsyncData(true),
          location: AppSection.goals.path,
        ),
        isNull,
      );
    });
  });
}
