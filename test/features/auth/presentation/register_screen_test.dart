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
import 'package:kairo/features/auth/data/timezone_source.dart';
import 'package:kairo/features/home/data/calendar_api.dart';
import 'package:kairo/features/time_tracking/data/timer_api.dart';

import '../../../helpers/fake_activities_api.dart';
import '../../../helpers/fake_auth_api.dart';
import '../../../helpers/fake_calendar_api.dart';
import '../../../helpers/fake_timer_api.dart';
import '../../../helpers/fake_timezone_source.dart';
import '../../../helpers/memory_token_storage.dart';

void main() {
  late MemoryTokenStorage storage;

  Future<FakeAuthApi> pumpRegister(
    WidgetTester tester, {
    Exception? registerError,
  }) async {
    storage = MemoryTokenStorage();
    final api = FakeAuthApi(registerError: registerError);
    await tester.pumpWidget(
      ProviderScope(
        retry: (retryCount, error) => null,
        overrides: [
          tokenStorageProvider.overrideWithValue(storage),
          authApiProvider.overrideWithValue(api),
          timezoneSourceProvider.overrideWithValue(const FakeTimezoneSource()),
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
    await tester.tap(find.text('Regístrate'));
    await tester.pumpAndSettle();
    return api;
  }

  Future<void> fill(WidgetTester tester, int index, String text) async {
    await tester.enterText(find.byType(TextFormField).at(index), text);
  }

  Future<void> submit(WidgetTester tester) async {
    await tester.ensureVisible(
      find.widgetWithText(FilledButton, 'Crear cuenta'),
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Crear cuenta'));
    await tester.pumpAndSettle();
  }

  testWidgets('preselecciona la zona horaria del dispositivo', (tester) async {
    await pumpRegister(tester);
    await tester.ensureVisible(find.text('Mexico City'));

    expect(find.text('Mexico City'), findsOneWidget);
    expect(
      find.text('America/Mexico_City · Tomada de tu dispositivo'),
      findsOneWidget,
    );
  });

  testWidgets('valida nombre, correo y contraseña antes de enviar', (
    tester,
  ) async {
    final api = await pumpRegister(tester);

    await submit(tester);

    expect(find.text('Escribe tu nombre'), findsOneWidget);
    expect(find.text('Escribe tu correo'), findsOneWidget);
    expect(find.text('Escribe tu contraseña'), findsOneWidget);
    expect(api.registerRequests, isEmpty);
  });

  testWidgets('permite cambiar la zona horaria desde la lista', (tester) async {
    await pumpRegister(tester);

    await tester.ensureVisible(find.text('Mexico City'));
    await tester.tap(find.text('Mexico City'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'canc');
    await tester.pumpAndSettle();
    await tester.tap(find.text('America/Cancun'));
    await tester.pumpAndSettle();

    expect(find.text('Cancun'), findsOneWidget);
  });

  testWidgets('crea la cuenta, inicia sesión y abre Inicio', (tester) async {
    final api = await pumpRegister(tester);

    await fill(tester, 0, ' Aurora ');
    await fill(tester, 1, 'aurora@correo.com');
    await fill(tester, 2, 'contrasena-segura');
    await submit(tester);

    final request = api.registerRequests.single;
    expect(request.name, 'Aurora');
    expect(request.timezone, 'America/Mexico_City');
    expect(api.loginRequests.single.email, 'aurora@correo.com');
    expect(storage.token, 'token-nuevo');
    expect(find.text('Inicio'), findsNWidgets(2));
  });

  testWidgets('muestra el error si el correo ya está registrado', (
    tester,
  ) async {
    final api = await pumpRegister(
      tester,
      registerError: const ValidationException('Ese correo ya está registrado'),
    );

    await fill(tester, 0, 'Aurora');
    await fill(tester, 1, 'aurora@correo.com');
    await fill(tester, 2, 'contrasena-segura');
    await submit(tester);

    expect(find.text('Ese correo ya está registrado'), findsOneWidget);
    expect(api.loginRequests, isEmpty);
    expect(storage.token, isNull);
  });

  testWidgets('regresa al inicio de sesión', (tester) async {
    await pumpRegister(tester);

    await tester.scrollUntilVisible(
      find.text('Inicia sesión'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Inicia sesión'));
    await tester.pumpAndSettle();

    expect(find.text('Ingresa tus datos para continuar'), findsOneWidget);
  });
}
