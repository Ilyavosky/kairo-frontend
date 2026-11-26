import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';
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

  Future<void> openForm(WidgetTester tester, FakeGoalsApi api) async {
    await pumpSignedInApp(
      tester,
      goalsApi: api,
      categoriesApi: FakeCategoriesApi(categories: [study, exercise]),
    );
    await tester.tap(find.text('Metas'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Nueva meta'));
    await tester.pumpAndSettle();
  }

  Future<void> tapVisible(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> chooseCategory(WidgetTester tester, String name) async {
    await tapVisible(tester, find.text('Selecciona una categoría'));
    await tester.tap(find.text(name).last);
    await tester.pumpAndSettle();
  }

  testWidgets('pide categoría y un objetivo mayor que cero', (tester) async {
    final api = FakeGoalsApi();
    await openForm(tester, api);

    expect(find.text('Nueva meta'), findsOneWidget);

    await tapVisible(tester, find.text('Guardar meta'));

    expect(find.text('Elige una categoría'), findsOneWidget);
    expect(find.text('El objetivo debe ser mayor que cero'), findsOneWidget);
    expect(api.created, isEmpty);
  });

  testWidgets('crea una meta de tiempo en minutos y aparece en Activas', (
    tester,
  ) async {
    final api = FakeGoalsApi();
    await openForm(tester, api);

    await chooseCategory(tester, 'Estudio');
    await tester.enterText(find.byType(TextFormField).at(0), '5');
    await tester.enterText(find.byType(TextFormField).at(1), '30');
    await tester.pumpAndSettle();

    expect(find.text('Tu meta: 5 h 30 min cada semana'), findsOneWidget);

    await tapVisible(tester, find.text('Guardar meta'));

    final input = api.created.single;
    expect(input.categoryId, 'categoria-estudio');
    expect(input.type, GoalType.time);
    expect(input.period, GoalPeriod.week);
    expect(input.target, 330);
    expect(find.text('Nueva meta'), findsNothing);
    expect(find.text('Estudio'), findsOneWidget);
  });

  testWidgets('crea una meta de registros diaria', (tester) async {
    final api = FakeGoalsApi();
    await openForm(tester, api);

    await chooseCategory(tester, 'Ejercicio');
    await tapVisible(tester, find.text('Registros'));
    await tapVisible(tester, find.text('Diaria'));
    await tester.enterText(find.byType(TextFormField), '2');
    await tester.pumpAndSettle();

    expect(find.text('Tu meta: 2 registros cada día'), findsOneWidget);

    await tapVisible(tester, find.text('Guardar meta'));

    final input = api.created.single;
    expect(input.type, GoalType.events);
    expect(input.period, GoalPeriod.day);
    expect(input.target, 2);
  });

  testWidgets('una meta duplicada muestra el mensaje del servidor', (
    tester,
  ) async {
    final api = FakeGoalsApi(
      createError: const ValidationException('El registro ya existe'),
    );
    await openForm(tester, api);

    await chooseCategory(tester, 'Estudio');
    await tester.enterText(find.byType(TextFormField).at(0), '2');
    await tester.pumpAndSettle();
    await tapVisible(tester, find.text('Guardar meta'));

    expect(find.text('El registro ya existe'), findsOneWidget);
    expect(find.text('Revisa los datos e intenta de nuevo.'), findsNothing);
    expect(find.text('Nueva meta'), findsOneWidget);
  });
}
