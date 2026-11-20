import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/app/kairo_app.dart';
import 'package:kairo/core/api/health_api.dart';
import 'package:kairo/core/api/models/health_status.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/core/storage/token_storage.dart';

import '../helpers/memory_token_storage.dart';

void main() {
  Future<void> pumpApp(
    WidgetTester tester, {
    String? token,
    Future<HealthStatus> Function()? health,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        retry: (retryCount, error) => null,
        overrides: [
          tokenStorageProvider.overrideWithValue(MemoryTokenStorage(token)),
          healthStatusProvider.overrideWith(
            (ref) =>
                health?.call() ??
                Future.value(const HealthStatus(status: 'healthy')),
          ),
        ],
        child: const KairoApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('sin sesión muestra el inicio de sesión y el servidor', (
    tester,
  ) async {
    await pumpApp(tester);

    expect(find.text('Inicio de sesión'), findsOneWidget);
    expect(find.text('Servidor disponible'), findsOneWidget);
  });

  testWidgets('si el servidor no responde muestra el error y reintentar', (
    tester,
  ) async {
    await pumpApp(tester, health: () => Future.error(const NetworkException()));

    expect(find.text(const NetworkException().message), findsOneWidget);
    expect(find.text('Reintentar'), findsOneWidget);
  });
  testWidgets('con sesión abre Inicio con las cinco secciones', (tester) async {
    await pumpApp(tester, token: 'token-guardado');

    expect(find.text('Inicio'), findsNWidgets(2));
    for (final label in ['Actividades', 'Tiempo', 'Metas', 'Más']) {
      expect(find.text(label), findsOneWidget);
    }
  });

  testWidgets('cambia de sección al tocar una pestaña', (tester) async {
    await pumpApp(tester, token: 'token-guardado');

    await tester.tap(find.text('Metas'));
    await tester.pumpAndSettle();

    expect(find.text('Metas'), findsNWidgets(2));
  });
}
