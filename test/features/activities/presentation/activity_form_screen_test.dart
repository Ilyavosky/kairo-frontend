import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';
import 'package:kairo/features/activities/domain/activity_modality.dart';
import 'package:kairo/features/activities/domain/activity_status.dart';
import 'package:kairo/features/subjects/data/models/subject.dart';

import '../../../helpers/fake_activities_api.dart';
import '../../../helpers/fake_categories_api.dart';
import '../../../helpers/fake_subjects_api.dart';
import '../../../helpers/pump_signed_in_app.dart';

void main() {
  const homework = ActivityCategory(
    id: 'categoria-1',
    name: 'Tarea',
    scope: 'academica',
    system: true,
  );
  const exam = ActivityCategory(
    id: 'categoria-2',
    name: 'Examen',
    scope: 'academica',
    system: true,
  );
  const security = Subject(
    id: 'materia-1',
    name: 'Seguridad informática',
    period: 'Ago - Dic 2026',
    active: true,
  );

  final report = Activity(
    id: 'a1',
    categoryId: 'categoria-1',
    title: 'Reporte de práctica 3',
    priority: 4,
    modality: ActivityModality.online,
    status: ActivityStatus.pending,
    createdAt: DateTime(2026, 11),
    subjectId: 'materia-1',
  );

  Future<FakeActivitiesApi> openActivities(
    WidgetTester tester, {
    List<Activity> activities = const [],
  }) async {
    final api = FakeActivitiesApi(activities: activities);
    await pumpSignedInApp(
      tester,
      activitiesApi: api,
      subjectsApi: FakeSubjectsApi(subjects: [security]),
      categoriesApi: FakeCategoriesApi(categories: [homework, exam]),
    );
    await tester.tap(find.text('Actividades'));
    await tester.pumpAndSettle();
    return api;
  }

  Future<void> tapInForm(WidgetTester tester, Finder finder) async {
    await tester.scrollUntilVisible(
      finder,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  testWidgets('valida título y categoría al crear', (tester) async {
    await openActivities(tester);
    await tester.tap(find.byTooltip('Nueva actividad'));
    await tester.pumpAndSettle();

    await tapInForm(tester, find.text('Guardar actividad'));

    expect(find.text('Escribe el título de la actividad'), findsOneWidget);
    expect(find.text('Elige una categoría'), findsOneWidget);
  });

  testWidgets('crea una actividad y aparece en la lista', (tester) async {
    final api = await openActivities(tester);
    await tester.tap(find.byTooltip('Nueva actividad'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextFormField).first,
      'Leer artículo de RLS',
    );
    await tapInForm(tester, find.text('Sin materia'));
    await tester.tap(find.text('Seguridad informática').last);
    await tester.pumpAndSettle();
    await tapInForm(tester, find.text('Selecciona una categoría'));
    await tester.tap(find.text('Examen').last);
    await tester.pumpAndSettle();
    await tapInForm(tester, find.text('5'));
    await tapInForm(tester, find.text('En línea'));
    await tapInForm(tester, find.text('Guardar actividad'));

    final input = api.created.single;
    expect(input.title, 'Leer artículo de RLS');
    expect(input.subjectId, 'materia-1');
    expect(input.categoryId, 'categoria-2');
    expect(input.priority, 5);
    expect(input.modality, ActivityModality.online);
    expect(input.dueAt, isNull);
    expect(find.text('Leer artículo de RLS'), findsOneWidget);
    expect(find.text('Nueva actividad'), findsNothing);
  });

  testWidgets('abre una actividad con sus datos y la edita', (tester) async {
    final api = await openActivities(tester, activities: [report]);

    await tester.tap(find.text('Reporte de práctica 3'));
    await tester.pumpAndSettle();

    expect(find.text('Editar actividad'), findsOneWidget);
    expect(find.text('Seguridad informática'), findsOneWidget);
    expect(find.text('Tarea'), findsOneWidget);

    await tester.enterText(
      find.byType(TextFormField).first,
      'Reporte de práctica 4',
    );
    await tapInForm(tester, find.text('Guardar cambios'));

    expect(api.updated['a1']?.title, 'Reporte de práctica 4');
    expect(api.updated['a1']?.categoryId, 'categoria-1');
    expect(find.text('Reporte de práctica 4'), findsOneWidget);
  });

  testWidgets('marca como completada desde el detalle', (tester) async {
    final api = await openActivities(tester, activities: [report]);

    await tester.tap(find.text('Reporte de práctica 3'));
    await tester.pumpAndSettle();
    await tapInForm(tester, find.text('Marcar como completada'));

    expect(api.completedIds, ['a1']);
    expect(find.text('Editar actividad'), findsNothing);
  });
}
