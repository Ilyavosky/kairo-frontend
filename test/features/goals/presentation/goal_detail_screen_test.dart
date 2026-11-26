import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

  Goal goal(String id, String categoryId) => Goal(
    id: id,
    categoryId: categoryId,
    type: GoalType.time,
    period: GoalPeriod.week,
    target: 300,
    validFrom: DateTime(2026, 11, 2),
    active: true,
  );

  GoalProgress progress(String goalId) => GoalProgress(
    goalId: goalId,
    target: 300,
    periodStart: DateTime(2026, 11, 23),
    periodEnd: DateTime(2026, 11, 30),
    progress: 60,
    percent: 20,
    achieved: false,
  );

  GoalEvaluation evaluation(
    String id,
    String goalId,
    DateTime start, {
    required bool achieved,
  }) => GoalEvaluation(
    id: id,
    goalId: goalId,
    periodStart: start,
    periodEnd: start.add(const Duration(days: 7)),
    target: 300,
    achievedValue: achieved ? 310 : 150,
    achieved: achieved,
  );

  FakeGoalsApi api() => FakeGoalsApi(
    goals: [
      goal('meta-1', 'categoria-estudio'),
      goal('meta-2', 'categoria-ejercicio'),
    ],
    progressById: {'meta-1': progress('meta-1'), 'meta-2': progress('meta-2')},
    evaluations: [
      evaluation('e1', 'meta-1', DateTime(2026, 11, 16), achieved: true),
      evaluation('e2', 'meta-1', DateTime(2026, 11, 9), achieved: false),
      evaluation('e3', 'meta-2', DateTime(2026, 11, 16), achieved: true),
    ],
  );

  Future<void> openDetail(WidgetTester tester, FakeGoalsApi goalsApi) async {
    await pumpSignedInApp(
      tester,
      goalsApi: goalsApi,
      categoriesApi: FakeCategoriesApi(categories: [study, exercise]),
    );
    await tester.tap(find.text('Metas'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Estudio'));
    await tester.pumpAndSettle();
  }

  testWidgets('muestra la meta y solo su historial', (tester) async {
    await openDetail(tester, api());

    expect(find.text('Detalle de la meta'), findsOneWidget);
    expect(find.text('1 h de 5 h'), findsOneWidget);
    expect(find.text('Activa desde el 02 nov 2026'), findsOneWidget);
    expect(find.text('16 nov – 22 nov'), findsOneWidget);
    expect(find.text('09 nov – 15 nov'), findsOneWidget);
    expect(find.text('Cumplida'), findsOneWidget);
    expect(find.text('No cumplida'), findsOneWidget);
    expect(find.text('Ejercicio'), findsNothing);
  });

  testWidgets('desactivar pide confirmación y quita la meta de Activas', (
    tester,
  ) async {
    final goalsApi = api();
    await openDetail(tester, goalsApi);

    await tester.scrollUntilVisible(
      find.text('Desactivar meta'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Desactivar meta'));
    await tester.pumpAndSettle();

    expect(find.textContaining('dejará de medirse'), findsOneWidget);

    await tester.tap(find.text('Desactivar'));
    await tester.pumpAndSettle();

    expect(goalsApi.deactivated, ['meta-1']);
    expect(find.text('Detalle de la meta'), findsNothing);
    expect(find.text('Meta de Estudio desactivada.'), findsOneWidget);
    expect(find.text('Estudio'), findsNothing);
    expect(find.text('Ejercicio'), findsOneWidget);
  });

  testWidgets('cancelar no desactiva la meta', (tester) async {
    final goalsApi = api();
    await openDetail(tester, goalsApi);

    await tester.scrollUntilVisible(
      find.text('Desactivar meta'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Desactivar meta'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();

    expect(goalsApi.deactivated, isEmpty);
    expect(find.text('Detalle de la meta'), findsOneWidget);
  });

  testWidgets('desde el historial abre una meta desactivada sin botón', (
    tester,
  ) async {
    final goalsApi = FakeGoalsApi(
      goals: [
        goal('meta-vieja', 'categoria-ejercicio').copyWith(active: false),
      ],
      evaluations: [
        evaluation('e9', 'meta-vieja', DateTime(2026, 11, 2), achieved: true),
      ],
    );
    await pumpSignedInApp(
      tester,
      goalsApi: goalsApi,
      categoriesApi: FakeCategoriesApi(categories: [study, exercise]),
    );
    await tester.tap(find.text('Metas'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Historial'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ejercicio'));
    await tester.pumpAndSettle();

    expect(find.text('Detalle de la meta'), findsOneWidget);
    expect(find.text('Desactivada'), findsOneWidget);
    expect(find.text('Semanal · Tiempo · Objetivo: 5 h'), findsOneWidget);
    expect(find.text('02 nov – 08 nov'), findsOneWidget);
    expect(find.text('Desactivar meta'), findsNothing);
  });

  testWidgets('cambia el objetivo de una meta activa', (tester) async {
    final goalsApi = api();
    await openDetail(tester, goalsApi);

    await tester.scrollUntilVisible(
      find.text('Cambiar objetivo'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Cambiar objetivo'));
    await tester.pumpAndSettle();

    expect(find.text('Guardar cambios'), findsOneWidget);
    expect(
      find.textContaining('Solo se puede cambiar el objetivo'),
      findsOneWidget,
    );
    expect(find.text('Estudio'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), '6');
    await tester.pumpAndSettle();

    expect(find.text('Tu meta: 6 h cada semana'), findsOneWidget);

    await tester.ensureVisible(find.text('Guardar cambios'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Guardar cambios'));
    await tester.pumpAndSettle();

    expect(goalsApi.updatedTargets, {'meta-1': 360});
    expect(goalsApi.created, isEmpty);
    expect(find.text('Detalle de la meta'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('1 h de 6 h'),
      -200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('1 h de 6 h'), findsOneWidget);
  });
}
