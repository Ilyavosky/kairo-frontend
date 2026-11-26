import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/app/kairo_app.dart';
import 'package:kairo/core/api/health_api.dart';
import 'package:kairo/core/api/models/health_status.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/core/storage/token_storage.dart';
import 'package:kairo/features/activities/data/activities_api.dart';
import 'package:kairo/features/activities/data/categories_api.dart';
import 'package:kairo/features/goals/data/goals_api.dart';
import 'package:kairo/features/home/data/calendar_api.dart';
import 'package:kairo/features/time_tracking/data/timer_api.dart';

import '../helpers/fake_activities_api.dart';
import '../helpers/fake_calendar_api.dart';
import '../helpers/fake_categories_api.dart';
import '../helpers/fake_goals_api.dart';
import '../helpers/fake_timer_api.dart';
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
          activitiesApiProvider.overrideWithValue(FakeActivitiesApi()),
          calendarApiProvider.overrideWithValue(FakeCalendarApi()),
          timerApiProvider.overrideWithValue(FakeTimerApi()),
          goalsApiProvider.overrideWithValue(FakeGoalsApi()),
          categoriesApiProvider.overrideWithValue(FakeCategoriesApi()),
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

  testWidgets('sin sesión muestra el inicio de sesión', (tester) async {
    await pumpApp(tester);

    expect(find.text('Ingresa tus datos para continuar'), findsOneWidget);
    expect(find.text('Reintentar'), findsNothing);
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
