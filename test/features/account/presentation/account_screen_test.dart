import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/features/auth/data/models/user_response.dart';

import '../../../helpers/fake_account_api.dart';
import '../../../helpers/pump_signed_in_app.dart';

void main() {
  Future<void> openAccount(WidgetTester tester, FakeAccountApi api) async {
    await pumpSignedInApp(tester, accountApi: api);
    await tester.tap(find.byTooltip('Mi cuenta'));
    await tester.pumpAndSettle();
  }

  testWidgets('el ícono de perfil abre la cuenta con la zona horaria', (
    tester,
  ) async {
    await openAccount(tester, FakeAccountApi());

    expect(find.text('Mi cuenta'), findsOneWidget);
    expect(find.text('Aurora'), findsOneWidget);
    expect(find.text('aurora@ejemplo.com'), findsOneWidget);
    expect(find.text('Mexico City (America/Mexico_City)'), findsOneWidget);
    expect(find.text('Sin vincular'), findsOneWidget);
    expect(find.byTooltip('Mi cuenta'), findsNothing);
  });

  testWidgets('muestra si Telegram está vinculado', (tester) async {
    await openAccount(
      tester,
      FakeAccountApi(
        user: UserResponse(
          id: 'usuario-1',
          email: 'aurora@ejemplo.com',
          name: 'Aurora',
          timezone: 'America/Mexico_City',
          registeredAt: DateTime(2026, 9),
          active: true,
          telegramId: 12345,
        ),
      ),
    );

    expect(find.text('Vinculado'), findsOneWidget);
  });

  testWidgets('cerrar sesión desde la cuenta regresa al login', (tester) async {
    await openAccount(tester, FakeAccountApi());

    await tester.scrollUntilVisible(
      find.widgetWithText(OutlinedButton, 'Cerrar sesión'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(OutlinedButton, 'Cerrar sesión'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Cerrar sesión'));
    await tester.pumpAndSettle();

    expect(find.text('Ingresa tus datos para continuar'), findsOneWidget);
  });

  testWidgets('si falla la carga deja reintentar', (tester) async {
    await openAccount(tester, FakeAccountApi(error: const NetworkException()));

    expect(find.text('Reintentar'), findsOneWidget);
  });
}
