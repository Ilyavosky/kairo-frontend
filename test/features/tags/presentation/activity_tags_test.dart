import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';
import 'package:kairo/features/activities/domain/activity_modality.dart';
import 'package:kairo/features/activities/domain/activity_status.dart';
import 'package:kairo/features/tags/data/models/tag.dart';

import '../../../helpers/fake_activities_api.dart';
import '../../../helpers/fake_categories_api.dart';
import '../../../helpers/fake_tags_api.dart';
import '../../../helpers/pump_signed_in_app.dart';

void main() {
  const homework = ActivityCategory(
    id: 'categoria-1',
    name: 'Tarea',
    scope: 'academica',
    system: true,
  );
  const urgent = Tag(id: 'etiqueta-1', name: 'Urgente');
  const team = Tag(id: 'etiqueta-2', name: 'En equipo');

  final report = Activity(
    id: 'a1',
    categoryId: 'categoria-1',
    title: 'Reporte de práctica 3',
    priority: 3,
    modality: ActivityModality.online,
    status: ActivityStatus.pending,
    createdAt: DateTime(2026, 11),
  );

  Future<void> openActivity(WidgetTester tester, FakeTagsApi tags) async {
    await pumpSignedInApp(
      tester,
      tagsApi: tags,
      activitiesApi: FakeActivitiesApi(activities: [report]),
      categoriesApi: FakeCategoriesApi(categories: [homework]),
    );
    await tester.tap(find.text('Actividades'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reporte de práctica 3'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Agregar etiqueta'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
  }

  testWidgets('muestra las etiquetas de la actividad', (tester) async {
    await openActivity(
      tester,
      FakeTagsApi(
        tags: [urgent, team],
        assigned: {
          'a1': ['etiqueta-1'],
        },
      ),
    );

    expect(find.text('Etiquetas'), findsOneWidget);
    expect(find.text('Urgente'), findsOneWidget);
    expect(find.text('En equipo'), findsNothing);
  });

  testWidgets('asigna una etiqueta existente', (tester) async {
    final tags = FakeTagsApi(tags: [urgent, team]);
    await openActivity(tester, tags);

    await tester.tap(find.text('Agregar etiqueta'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('En equipo'));
    await tester.pumpAndSettle();

    expect(tags.assignments, [('a1', 'etiqueta-2')]);
    expect(find.text('En equipo'), findsOneWidget);
  });

  testWidgets('crea una etiqueta nueva y la asigna', (tester) async {
    final tags = FakeTagsApi();
    await openActivity(tester, tags);

    await tester.tap(find.text('Agregar etiqueta'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Crear etiqueta nueva'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Crear'));
    await tester.pumpAndSettle();

    expect(find.text('Escribe el nombre de la etiqueta'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).last, 'Examen final');
    await tester.tap(find.text('Crear'));
    await tester.pumpAndSettle();

    expect(tags.createdNames, ['Examen final']);
    expect(tags.assignments.single.$1, 'a1');
    expect(find.text('Examen final'), findsOneWidget);
  });

  testWidgets('quita una etiqueta de la actividad', (tester) async {
    final tags = FakeTagsApi(
      tags: [urgent],
      assigned: {
        'a1': ['etiqueta-1'],
      },
    );
    await openActivity(tester, tags);

    await tester.tap(find.byTooltip('Quitar Urgente'));
    await tester.pumpAndSettle();

    expect(tags.removals, [('a1', 'etiqueta-1')]);
    expect(find.text('Urgente'), findsNothing);
  });
}
