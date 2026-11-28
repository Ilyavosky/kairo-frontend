import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/features/goals/domain/goal_period.dart';
import 'package:kairo/features/goals/domain/goal_type.dart';
import 'package:kairo/features/reports/data/models/goal_report.dart';
import 'package:kairo/features/reports/data/models/rest_week.dart';
import 'package:kairo/features/reports/data/models/weekly_load.dart';
import 'package:kairo/features/self_assessment/domain/week.dart';

import '../../../helpers/fake_reports_api.dart';
import '../../../helpers/pump_signed_in_app.dart';

void main() {
  final monday = Week.mondayOf(DateTime.now());
  DateTime weeksAgo(int n) =>
      DateTime(monday.year, monday.month, monday.day - 7 * n);

  WeeklyLoad load(DateTime week, String subject, int deliveries) => WeeklyLoad(
    weekStart: week,
    subject: subject,
    deliveries: deliveries,
    pending: 0,
    minutes: 90,
  );

  RestWeek rest(DateTime week) => RestWeek(
    weekStart: week,
    academicMinutes: 600,
    sleepMinutes: 2940,
    exerciseMinutes: 120,
  );

  const studyGoal = GoalReport(
    goalId: 'meta-1',
    category: 'Estudio',
    type: GoalType.time,
    period: GoalPeriod.week,
    target: 300,
    progress: 150,
    percent: 50,
    achieved: false,
  );

  Future<void> openReports(WidgetTester tester, FakeReportsApi api) async {
    await pumpSignedInApp(tester, reportsApi: api);
    await tester.tap(find.text('Más'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reportes'));
    await tester.pumpAndSettle();
  }

  Future<void> scrollTo(WidgetTester tester, Finder finder) async {
    await tester.scrollUntilVisible(
      finder,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
  }

  testWidgets('con menos de tres semanas no dibuja la tendencia', (
    tester,
  ) async {
    await openReports(
      tester,
      FakeReportsApi(
        loads: [load(monday, 'Redes', 2)],
        rest: [rest(weeksAgo(1)), rest(monday)],
      ),
    );

    await scrollTo(tester, find.text('Necesitas más semanas de datos'));

    expect(find.text('Necesitas más semanas de datos'), findsOneWidget);
    expect(find.textContaining('Llevas 2 de 3'), findsOneWidget);
    expect(find.byType(LineChart), findsNothing);
  });

  testWidgets('con tres semanas muestra la tendencia con las cifras', (
    tester,
  ) async {
    await openReports(
      tester,
      FakeReportsApi(
        loads: [
          load(weeksAgo(2), 'Redes', 1),
          load(weeksAgo(1), 'Redes', 2),
          load(weeksAgo(1), 'Cálculo', 2),
          load(monday, 'Redes', 3),
        ],
        rest: [rest(weeksAgo(2)), rest(weeksAgo(1)), rest(monday)],
      ),
    );

    await scrollTo(tester, find.byType(LineChart));

    expect(find.byType(LineChart), findsOneWidget);
    expect(find.text('Necesitas más semanas de datos'), findsNothing);

    await scrollTo(
      tester,
      find.text('4 entregas · sueño 49 h (7 h por noche) · ejercicio 2 h'),
    );

    expect(find.text(Week.label(weeksAgo(1))), findsOneWidget);
    expect(
      find.text('4 entregas · sueño 49 h (7 h por noche) · ejercicio 2 h'),
      findsOneWidget,
    );
  });

  testWidgets('la carga por materia cambia con el selector de semana', (
    tester,
  ) async {
    await openReports(
      tester,
      FakeReportsApi(
        loads: [load(weeksAgo(1), 'Cálculo', 2), load(monday, 'Redes', 3)],
      ),
    );

    expect(find.text('Esta semana'), findsOneWidget);
    expect(find.byType(BarChart), findsOneWidget);
    expect(find.text('Redes'), findsWidgets);
    expect(find.text('3 entregas · 1 h 30 min registradas'), findsOneWidget);

    await tester.tap(find.byTooltip('Semana anterior'));
    await tester.pumpAndSettle();

    expect(find.text(Week.label(weeksAgo(1))), findsOneWidget);
    expect(find.text('2 entregas · 1 h 30 min registradas'), findsOneWidget);
    expect(find.text('3 entregas · 1 h 30 min registradas'), findsNothing);
  });

  testWidgets('una semana sin carga lo dice en lugar de graficar', (
    tester,
  ) async {
    await openReports(tester, FakeReportsApi());

    expect(
      find.text('No tienes entregas ni tiempo registrado en esta semana.'),
      findsOneWidget,
    );
    expect(find.byType(BarChart), findsNothing);
  });

  testWidgets('muestra el progreso de metas y el resumen redactado', (
    tester,
  ) async {
    await openReports(
      tester,
      FakeReportsApi(
        goalReports: [studyGoal],
        summaryText: 'Esta semana tienes 3 entregas de Redes.',
      ),
    );

    expect(
      find.text('Esta semana tienes 3 entregas de Redes.'),
      findsOneWidget,
    );

    await scrollTo(tester, find.text('Estudio · Semanal'));

    expect(find.text('2 h 30 min de 5 h'), findsOneWidget);
    expect(find.text('50 %'), findsOneWidget);
  });

  testWidgets('el resumen carga sin bloquear las gráficas', (tester) async {
    final hold = Completer<void>();
    await openReports(
      tester,
      FakeReportsApi(loads: [load(monday, 'Redes', 3)], summaryHold: hold),
    );

    expect(find.byKey(const ValueKey('resumen-cargando')), findsOneWidget);
    expect(find.byType(BarChart), findsOneWidget);

    hold.complete();
    await tester.pumpAndSettle();

    expect(
      find.textContaining('no se pudo redactar el resumen'),
      findsOneWidget,
    );
  });

  testWidgets('si falla la carga deja reintentar', (tester) async {
    await openReports(
      tester,
      FakeReportsApi(loadError: const NetworkException()),
    );

    expect(find.text('Reintentar'), findsOneWidget);
  });
}
