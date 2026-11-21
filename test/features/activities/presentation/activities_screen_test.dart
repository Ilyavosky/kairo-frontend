import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/domain/activity_modality.dart';
import 'package:kairo/features/activities/domain/activity_status.dart';
import 'package:kairo/features/subjects/data/models/subject.dart';

import '../../../helpers/fake_activities_api.dart';
import '../../../helpers/fake_subjects_api.dart';
import '../../../helpers/pump_signed_in_app.dart';

void main() {
  final created = DateTime(2026, 11);

  Activity activity(
    String id,
    String title, {
    ActivityStatus status = ActivityStatus.pending,
    String? subjectId,
  }) => Activity(
    id: id,
    categoryId: 'categoria-1',
    title: title,
    priority: 3,
    modality: ActivityModality.inPerson,
    status: status,
    createdAt: created,
    subjectId: subjectId,
  );

  const security = Subject(
    id: 'materia-1',
    name: 'Seguridad informática',
    period: 'Ago - Dic 2026',
    active: true,
  );

  Future<FakeActivitiesApi> openActivities(
    WidgetTester tester, {
    List<Activity> activities = const [],
    Exception? listError,
    Exception? completeError,
  }) async {
    final api = FakeActivitiesApi(
      activities: activities,
      listError: listError,
      completeError: completeError,
    );
    await pumpSignedInApp(
      tester,
      activitiesApi: api,
      subjectsApi: FakeSubjectsApi(subjects: [security]),
    );
    await tester.tap(find.text('Actividades'));
    await tester.pumpAndSettle();
    return api;
  }

  Finder checkboxOf(String title) => find.descendant(
    of: find.ancestor(of: find.text(title), matching: find.byType(Card)),
    matching: find.byType(Checkbox),
  );

  testWidgets('sin actividades muestra el estado vacío', (tester) async {
    await openActivities(tester);

    expect(find.text('Aún no tienes actividades'), findsOneWidget);
  });

  testWidgets('muestra las actividades con su materia', (tester) async {
    await openActivities(
      tester,
      activities: [
        activity('a1', 'Reporte de práctica 3', subjectId: 'materia-1'),
        activity('a2', 'Leer capítulo 4'),
      ],
    );

    expect(find.text('Reporte de práctica 3'), findsOneWidget);
    expect(find.text('Seguridad informática'), findsOneWidget);
    expect(find.text('Sin materia'), findsOneWidget);
  });

  testWidgets('si falla la carga muestra el error y reintentar', (
    tester,
  ) async {
    await openActivities(tester, listError: const NetworkException());

    expect(find.text(const NetworkException().message), findsOneWidget);
    expect(find.text('Reintentar'), findsOneWidget);
  });

  testWidgets('filtra por estado', (tester) async {
    final api = await openActivities(
      tester,
      activities: [
        activity('a1', 'Reporte de práctica 3'),
        activity('a2', 'Exposición', status: ActivityStatus.completed),
      ],
    );

    await tester.tap(find.text('Completadas'));
    await tester.pumpAndSettle();

    expect(api.filters.last.status, ActivityStatus.completed);
    expect(find.text('Exposición'), findsOneWidget);
    expect(find.text('Reporte de práctica 3'), findsNothing);
  });

  testWidgets('filtra por materia', (tester) async {
    final api = await openActivities(
      tester,
      activities: [
        activity('a1', 'Reporte de práctica 3', subjectId: 'materia-1'),
        activity('a2', 'Leer capítulo 4'),
      ],
    );

    await tester.tap(find.text('Todas las materias'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Seguridad informática').last);
    await tester.pumpAndSettle();

    expect(api.filters.last.subjectId, 'materia-1');
    expect(find.text('Leer capítulo 4'), findsNothing);
  });

  testWidgets('completar en pendientes la quita sin recargar', (tester) async {
    final api = await openActivities(
      tester,
      activities: [activity('a1', 'Reporte de práctica 3')],
    );
    await tester.tap(find.text('Pendientes'));
    await tester.pumpAndSettle();
    final requests = api.filters.length;

    await tester.tap(checkboxOf('Reporte de práctica 3'));
    await tester.pumpAndSettle();

    expect(api.completedIds, ['a1']);
    expect(find.text('Reporte de práctica 3'), findsNothing);
    expect(api.filters.length, requests);
  });

  testWidgets('si falla la red la actividad regresa y se muestra el error', (
    tester,
  ) async {
    await openActivities(
      tester,
      activities: [activity('a1', 'Reporte de práctica 3')],
      completeError: const NetworkException(),
    );
    await tester.tap(find.text('Pendientes'));
    await tester.pumpAndSettle();

    await tester.tap(checkboxOf('Reporte de práctica 3'));
    await tester.pumpAndSettle();

    expect(find.text('Reporte de práctica 3'), findsOneWidget);
    expect(
      find.textContaining('No se pudo completar "Reporte de práctica 3"'),
      findsOneWidget,
    );
  });

  testWidgets('desmarcar una completada la regresa a pendiente', (
    tester,
  ) async {
    final api = await openActivities(
      tester,
      activities: [
        activity('a1', 'Exposición', status: ActivityStatus.completed),
      ],
    );

    await tester.tap(checkboxOf('Exposición'));
    await tester.pumpAndSettle();

    expect(api.reopenedIds, ['a1']);
    final checkbox = tester.widget<Checkbox>(checkboxOf('Exposición'));
    expect(checkbox.value, isFalse);
  });

  testWidgets('desmarcar en completadas la quita de la lista', (tester) async {
    await openActivities(
      tester,
      activities: [
        activity('a1', 'Exposición', status: ActivityStatus.completed),
      ],
    );
    await tester.tap(find.text('Completadas'));
    await tester.pumpAndSettle();

    await tester.tap(checkboxOf('Exposición'));
    await tester.pumpAndSettle();

    expect(find.text('Exposición'), findsNothing);
  });
}
