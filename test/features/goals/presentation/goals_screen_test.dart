import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';
import 'package:kairo/features/goals/data/models/goal.dart';
import 'package:kairo/features/goals/data/models/goal_evaluation.dart';
import 'package:kairo/features/goals/data/models/goal_progress.dart';
import 'package:kairo/features/goals/domain/goal_period.dart';
import 'package:kairo/features/goals/domain/goal_type.dart';

import '../../../helpers/fake_categories_api.dart';
import '../../../helpers/fake_goals_api.dart';
import '../../../helpers/pump_signed_in_app.dart';

void main() {
  const study = ActivityCategory(
    id: 'categoria-estudio',
    name: 'Estudio',
    scope: 'ambas',
    system: true,
  );
  const exercise = ActivityCategory(
    id: 'categoria-ejercicio',
    name: 'Ejercicio',
    scope: 'personal',
    system: true,
  );

  final studyGoal = Goal(
    id: 'meta-1',
    categoryId: 'categoria-estudio',
    type: GoalType.time,
    period: GoalPeriod.week,
    target: 300,
    validFrom: DateTime(2026, 11),
    active: true,
  );
  final exerciseGoal = Goal(
    id: 'meta-2',
    categoryId: 'categoria-ejercicio',
    type: GoalType.events,
    period: GoalPeriod.day,
    target: 1,
    validFrom: DateTime(2026, 11),
    active: true,
  );

  GoalProgress progress(
    String goalId,
    int target,
    double value,
    double percent, {
    bool achieved = false,
  }) => GoalProgress(
    goalId: goalId,
    target: target,
    periodStart: DateTime.utc(2026, 11, 23, 6),
    periodEnd: DateTime.utc(2026, 11, 30, 6),
    progress: value,
    percent: percent,
    achieved: achieved,
  );

  Future<void> openGoals(WidgetTester tester, FakeGoalsApi api) async {
    await pumpSignedInApp(
      tester,
      goalsApi: api,
      categoriesApi: FakeCategoriesApi(categories: [study, exercise]),
    );
    await tester.tap(find.text('Metas'));
    await tester.pumpAndSettle();
  }

  testWidgets('sin metas muestra el estado vacío', (tester) async {
    await openGoals(tester, FakeGoalsApi());

    expect(find.text('Aún no tienes metas'), findsOneWidget);
  });

  testWidgets('muestra cada meta con el progreso que da la API', (
    tester,
  ) async {
    await openGoals(
      tester,
      FakeGoalsApi(
        goals: [studyGoal, exerciseGoal],
        progressById: {
          'meta-1': progress('meta-1', 300, 90, 30),
          'meta-2': progress('meta-2', 1, 1, 100, achieved: true),
        },
      ),
    );

    expect(find.text('Estudio'), findsOneWidget);
    expect(find.text('Semanal · Tiempo · Esta semana'), findsOneWidget);
    expect(find.text('1 h 30 min de 5 h'), findsOneWidget);
    expect(find.text('30 %'), findsOneWidget);
    expect(find.text('En progreso'), findsOneWidget);

    expect(find.text('Ejercicio'), findsOneWidget);
    expect(find.text('1 de 1 registro'), findsOneWidget);
    expect(find.text('100 %'), findsOneWidget);
    expect(find.text('Cumplida'), findsOneWidget);

    final bars = tester
        .widgetList<LinearProgressIndicator>(
          find.byType(LinearProgressIndicator),
        )
        .map((bar) => bar.value)
        .toList();
    expect(bars, [0.3, 1.0]);
  });

  testWidgets('el historial marca cada periodo como cumplido o no', (
    tester,
  ) async {
    await openGoals(
      tester,
      FakeGoalsApi(
        goals: [studyGoal],
        progressById: {'meta-1': progress('meta-1', 300, 0, 0)},
        evaluations: [
          GoalEvaluation(
            id: 'e1',
            goalId: 'meta-1',
            periodStart: DateTime(2026, 11, 16),
            periodEnd: DateTime(2026, 11, 23),
            target: 300,
            achievedValue: 320,
            achieved: true,
          ),
          GoalEvaluation(
            id: 'e2',
            goalId: 'meta-1',
            periodStart: DateTime(2026, 11, 9),
            periodEnd: DateTime(2026, 11, 16),
            target: 300,
            achievedValue: 120,
            achieved: false,
          ),
        ],
      ),
    );

    await tester.tap(find.text('Historial'));
    await tester.pumpAndSettle();

    expect(find.text('16 nov – 22 nov'), findsOneWidget);
    expect(find.text('5 h 20 min de 5 h'), findsOneWidget);
    expect(find.text('Cumplida'), findsOneWidget);
    expect(find.text('09 nov – 15 nov'), findsOneWidget);
    expect(find.text('2 h de 5 h'), findsOneWidget);
    expect(find.text('No cumplida'), findsOneWidget);
  });

  testWidgets('si falla la carga muestra el error y reintentar', (
    tester,
  ) async {
    await openGoals(tester, FakeGoalsApi(listError: const NetworkException()));

    expect(find.text(const NetworkException().message), findsOneWidget);
    expect(find.text('Reintentar'), findsOneWidget);
  });
}
