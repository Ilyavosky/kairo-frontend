import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_signed_in_app.dart';

void main() {
  testWidgets('cerrar sesión borra el token y regresa al login', (
    tester,
  ) async {
    final storage = await pumpSignedInApp(tester);

    await tester.tap(find.text('Más'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(OutlinedButton, 'Cerrar sesión'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Cerrar sesión'));
    await tester.pumpAndSettle();

    expect(storage.token, isNull);
    expect(find.text('Ingresa tus datos para continuar'), findsOneWidget);
  });
}
