import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/features/subjects/data/models/subject.dart';

import '../../../helpers/fake_subjects_api.dart';
import '../../../helpers/pump_signed_in_app.dart';

void main() {
  const security = Subject(
    id: 'materia-1',
    name: 'Seguridad informática',
    period: 'Ago - Dic 2026',
    active: true,
    teacher: 'Mtro. Ruiz',
    code: 'SEG-701',
  );

  Future<FakeSubjectsApi> openSubjects(
    WidgetTester tester, {
    List<Subject> subjects = const [],
    Exception? listError,
  }) async {
    final api = FakeSubjectsApi(subjects: subjects, listError: listError);
    await pumpSignedInApp(tester, subjectsApi: api);
    await tester.tap(find.text('Más'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Materias'));
    await tester.pumpAndSettle();
    return api;
  }

  Future<void> fill(WidgetTester tester, int index, String text) async {
    await tester.enterText(find.byType(TextFormField).at(index), text);
  }

  Future<void> tapButton(WidgetTester tester, String label) async {
    final button = find.text(label);
    await tester.scrollUntilVisible(
      button,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(button);
    await tester.pumpAndSettle();
  }

  testWidgets('sin materias muestra el estado vacío', (tester) async {
    await openSubjects(tester);

    expect(find.text('Aún no tienes materias'), findsOneWidget);
    expect(find.text('Agregar materia'), findsOneWidget);
  });

  testWidgets('muestra las materias activas', (tester) async {
    await openSubjects(tester, subjects: [security]);

    expect(find.text('Seguridad informática'), findsOneWidget);
    expect(find.text('Mtro. Ruiz'), findsOneWidget);
    expect(find.text('SEG-701'), findsOneWidget);
  });

  testWidgets('si falla la carga muestra el error y reintentar', (
    tester,
  ) async {
    await openSubjects(tester, listError: const NetworkException());

    expect(find.text(const NetworkException().message), findsOneWidget);
    expect(find.text('Reintentar'), findsOneWidget);
  });

  testWidgets('valida nombre y periodo al crear', (tester) async {
    await openSubjects(tester);

    await tester.tap(find.text('Agregar materia'));
    await tester.pumpAndSettle();
    await tapButton(tester, 'Guardar materia');

    expect(find.text('Escribe el nombre de la materia'), findsOneWidget);
    expect(find.text('Escribe el periodo de la materia'), findsOneWidget);
  });

  testWidgets('crea una materia y aparece en la lista', (tester) async {
    await openSubjects(tester);

    await tester.tap(find.text('Agregar materia'));
    await tester.pumpAndSettle();
    await fill(tester, 0, 'Base de Datos en la Nube');
    await fill(tester, 1, 'BDN-703');
    await fill(tester, 3, 'Ago - Dic 2026');
    await tapButton(tester, 'Guardar materia');

    expect(find.text('Materias'), findsWidgets);
    expect(find.text('Base de Datos en la Nube'), findsOneWidget);
    expect(find.text('Sin docente'), findsOneWidget);
  });

  testWidgets('edita una materia', (tester) async {
    await openSubjects(tester, subjects: [security]);

    await tester.tap(find.text('Seguridad informática'));
    await tester.pumpAndSettle();
    await fill(tester, 2, 'Mtra. Pérez');
    await tapButton(tester, 'Guardar cambios');

    expect(find.text('Mtra. Pérez'), findsOneWidget);
  });

  testWidgets('archiva una materia después de confirmar', (tester) async {
    final api = await openSubjects(tester, subjects: [security]);

    await tester.tap(find.text('Seguridad informática'));
    await tester.pumpAndSettle();
    await tapButton(tester, 'Archivar materia');
    await tester.tap(find.widgetWithText(FilledButton, 'Archivar'));
    await tester.pumpAndSettle();

    expect(api.archivedIds, ['materia-1']);
    expect(find.text('Aún no tienes materias'), findsOneWidget);
  });
}
