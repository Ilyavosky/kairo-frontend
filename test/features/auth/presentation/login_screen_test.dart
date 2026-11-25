import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/app/kairo_app.dart';
import 'package:kairo/core/api/health_api.dart';
import 'package:kairo/core/api/models/health_status.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/core/storage/token_storage.dart';
import 'package:kairo/features/activities/data/activities_api.dart';
import 'package:kairo/features/auth/data/auth_api.dart';
import 'package:kairo/features/home/data/calendar_api.dart';
import 'package:kairo/features/time_tracking/data/timer_api.dart';

import '../../../helpers/fake_activities_api.dart';
import '../../../helpers/fake_auth_api.dart';
import '../../../helpers/fake_calendar_api.dart';
import '../../../helpers/fake_timer_api.dart';
import '../../../helpers/memory_token_storage.dart';

void main() {
  late MemoryTokenStorage storage;

  Future<FakeAuthApi> pumpLogin(WidgetTester tester, {Exception? error}) async {
    storage = MemoryTokenStorage();
    final api = FakeAuthApi(loginError: error);
    await tester.pumpWidget(
      ProviderScope(
        retry: (retryCount, error) => null,
        overrides: [
          tokenStorageProvider.overrideWithValue(storage),
          authApiProvider.overrideWithValue(api),
          activitiesApiProvider.overrideWithValue(FakeActivitiesApi()),
          calendarApiProvider.overrideWithValue(FakeCalendarApi()),
          timerApiProvider.overrideWithValue(FakeTimerApi()),
          healthStatusProvider.overrideWith(
            (ref) => Future.value(const HealthStatus(status: 'healthy')),
          ),
        ],
        child: const KairoApp(),
      ),
    );
    await tester.pumpAndSettle();
    return api;
  }

  Future<void> fill(WidgetTester tester, String label, String text) async {
    final index = label == 'Correo' ? 0 : 1;
    await tester.enterText(find.byType(TextFormField).at(index), text);
  }

  Future<void> submit(WidgetTester tester) async {
    await tester.tap(find.widgetWithText(FilledButton, 'Iniciar sesión'));
    await tester.pumpAndSettle();
  }

  testWidgets('pide correo y contraseña si el formulario está vacío', (
    tester,
  ) async {
    final api = await pumpLogin(tester);

    await submit(tester);

    expect(find.text('Escribe tu correo'), findsOneWidget);
    expect(find.text('Escribe tu contraseña'), findsOneWidget);
    expect(api.loginRequests, isEmpty);
  });

  testWidgets('valida el formato del correo y el largo de la contraseña', (
    tester,
  ) async {
    final api = await pumpLogin(tester);

    await fill(tester, 'Correo', 'aurora@correo');
    await fill(tester, 'Contraseña', '1234');
    await submit(tester);

    expect(find.text('Escribe un correo válido'), findsOneWidget);
    expect(
      find.text('La contraseña debe tener al menos 8 caracteres'),
      findsOneWidget,
    );
    expect(api.loginRequests, isEmpty);
  });

  testWidgets('muestra el mensaje del servidor ante un 401', (tester) async {
    await pumpLogin(
      tester,
      error: const UnauthorizedException('Correo o contraseña incorrectos'),
    );

    await fill(tester, 'Correo', 'aurora@correo.com');
    await fill(tester, 'Contraseña', 'contrasena-mala');
    await submit(tester);

    expect(find.text('Correo o contraseña incorrectos'), findsOneWidget);
    expect(storage.token, isNull);
  });

  testWidgets('con datos correctos guarda el token y abre Inicio', (
    tester,
  ) async {
    final api = await pumpLogin(tester);

    await fill(tester, 'Correo', '  aurora@correo.com ');
    await fill(tester, 'Contraseña', 'contrasena-segura');
    await submit(tester);

    expect(api.loginRequests.single.email, 'aurora@correo.com');
    expect(storage.token, 'token-nuevo');
    expect(find.text('Inicio'), findsNWidgets(2));
  });
}
