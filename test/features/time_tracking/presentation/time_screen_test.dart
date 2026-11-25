import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';
import 'package:kairo/features/activities/domain/activity_modality.dart';
import 'package:kairo/features/activities/domain/activity_status.dart';
import 'package:kairo/features/time_tracking/data/models/timer_session.dart';

import '../../../helpers/fake_activities_api.dart';
import '../../../helpers/fake_categories_api.dart';
import '../../../helpers/fake_timer_api.dart';
import '../../../helpers/pump_signed_in_app.dart';

void main() {
  const study = ActivityCategory(
    id: 'categoria-estudio',
    name: 'Estudio',
    scope: 'ambas',
    system: true,
  );
  const sleep = ActivityCategory(
    id: 'categoria-sueno',
    name: 'Sueño',
    scope: 'personal',
    system: true,
  );

  final report = Activity(
    id: 'a1',
    categoryId: 'categoria-estudio',
    title: 'Reporte de práctica 3',
    priority: 3,
    modality: ActivityModality.online,
    status: ActivityStatus.pending,
    createdAt: DateTime(2026, 11),
  );

  TimerSession session({int elapsedSeconds = 0, String? activityId}) =>
      TimerSession(
        id: 'sesion-1',
        categoryId: 'categoria-estudio',
        activityId: activityId,
        startedAt: DateTime.now().subtract(Duration(seconds: elapsedSeconds)),
        elapsedSeconds: elapsedSeconds,
      );

  Future<void> settleFrames(WidgetTester tester) async {
    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  Future<void> tapVisible(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(finder);
  }

  Future<FakeTimerApi> openTime(
    WidgetTester tester, {
    FakeTimerApi? timerApi,
  }) async {
    final api = timerApi ?? FakeTimerApi();
    await pumpSignedInApp(
      tester,
      timerApi: api,
      categoriesApi: FakeCategoriesApi(categories: [study, sleep]),
      activitiesApi: FakeActivitiesApi(activities: [report]),
    );
    await tester.tap(find.text('Tiempo'));
    await settleFrames(tester);
    return api;
  }

  testWidgets('sin temporizador pide elegir qué cronometrar', (tester) async {
    await openTime(tester);

    expect(find.text('00:00:00'), findsOneWidget);

    await tapVisible(tester, find.text('Iniciar'));
    await settleFrames(tester);

    expect(find.text('Elige qué vas a cronometrar'), findsOneWidget);
  });

  testWidgets('elegir una actividad toma su categoría e inicia', (
    tester,
  ) async {
    final api = await openTime(tester);

    await tapVisible(tester, find.text('Sin actividad'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reporte de práctica 3').last);
    await tester.pumpAndSettle();

    expect(find.text('Estudio'), findsOneWidget);

    await tapVisible(tester, find.text('Iniciar'));
    await settleFrames(tester);

    expect(api.started.single.categoryId, 'categoria-estudio');
    expect(api.started.single.activityId, 'a1');
    expect(find.text('Detener y guardar'), findsOneWidget);
    expect(find.text('Reporte de práctica 3'), findsOneWidget);
  });

  testWidgets('al abrir recupera el temporizador del servidor', (tester) async {
    await openTime(
      tester,
      timerApi: FakeTimerApi(running: session(elapsedSeconds: 3725)),
    );

    expect(find.text('01:02:05'), findsOneWidget);
    expect(find.text('Estudio'), findsOneWidget);
    expect(find.text('Detener y guardar'), findsOneWidget);
  });

  testWidgets('detener guarda el registro con la nota', (tester) async {
    final api = await openTime(
      tester,
      timerApi: FakeTimerApi(running: session(elapsedSeconds: 1500)),
    );

    await tester.ensureVisible(find.byType(TextFormField));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.enterText(find.byType(TextFormField), 'Capítulo 3');
    await tapVisible(tester, find.text('Detener y guardar'));
    await settleFrames(tester);

    expect(api.stopNotes, ['Capítulo 3']);
    expect(find.text('Guardado: 25 min de Estudio.'), findsOneWidget);
    expect(find.text('00:00:00'), findsOneWidget);
  });

  testWidgets('si no hay red al detener sigue corriendo y avisa', (
    tester,
  ) async {
    await openTime(
      tester,
      timerApi: FakeTimerApi(
        running: session(elapsedSeconds: 60),
        stopError: const NetworkException(),
      ),
    );

    await tapVisible(tester, find.text('Detener y guardar'));
    await settleFrames(tester);

    expect(find.text('Detener y guardar'), findsOneWidget);
    expect(
      find.text(
        'Sin conexión. El temporizador sigue corriendo en el servidor.',
      ),
      findsOneWidget,
    );
    expect(
      find.text('No se pudo detener. ${const NetworkException().message}'),
      findsOneWidget,
    );
  });

  testWidgets('si falla la carga muestra el error y reintentar', (
    tester,
  ) async {
    await openTime(
      tester,
      timerApi: FakeTimerApi(currentError: const NetworkException()),
    );

    expect(find.text(const NetworkException().message), findsOneWidget);
    expect(find.text('Reintentar'), findsOneWidget);
  });
}
