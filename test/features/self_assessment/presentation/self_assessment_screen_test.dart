import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/features/self_assessment/data/models/self_assessment.dart';
import 'package:kairo/features/self_assessment/domain/week.dart';

import '../../../helpers/fake_self_assessment_api.dart';
import '../../../helpers/pump_signed_in_app.dart';

void main() {
  final monday = Week.mondayOf(DateTime.now());
  final lastMonday = DateTime(monday.year, monday.month, monday.day - 7);

  SelfAssessment assessment(
    DateTime week,
    int mood,
    int satisfaction, {
    String? note,
  }) => SelfAssessment(
    weekStart: week,
    mood: mood,
    satisfaction: satisfaction,
    note: note,
    createdAt: week,
    updatedAt: week,
  );

  Future<void> openSelfAssessment(
    WidgetTester tester,
    FakeSelfAssessmentApi api,
  ) async {
    await pumpSignedInApp(tester, selfAssessmentApi: api);
    await tester.tap(find.text('Más'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Autoevaluación semanal'));
    await tester.pumpAndSettle();
  }

  Future<void> tapVisible(WidgetTester tester, Finder finder) async {
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  testWidgets('sin evaluaciones invita a evaluar la semana', (tester) async {
    await openSelfAssessment(tester, FakeSelfAssessmentApi());

    expect(find.text('Esta semana'), findsOneWidget);
    expect(find.text(Week.label(monday)), findsOneWidget);
    expect(find.text('Evaluar mi semana'), findsOneWidget);
    expect(
      find.textContaining('Aún no tienes semanas anteriores'),
      findsOneWidget,
    );
  });

  testWidgets('evaluar la semana manda el lunes y las calificaciones', (
    tester,
  ) async {
    final api = FakeSelfAssessmentApi();
    await openSelfAssessment(tester, api);

    await tapVisible(tester, find.text('Evaluar mi semana'));
    expect(find.text('Evaluar semana'), findsOneWidget);

    await tapVisible(tester, find.text('4').first);
    await tapVisible(tester, find.text('5').last);
    await tester.enterText(
      find.byType(TextFormField),
      'Terminé la migración a tiempo',
    );
    await tapVisible(tester, find.text('Guardar evaluación'));

    final (week, input) = api.saved.single;
    expect(Week.same(week, monday), isTrue);
    expect(input.mood, 4);
    expect(input.satisfaction, 5);
    expect(input.note, 'Terminé la migración a tiempo');
    expect(find.text('Autoevaluación guardada.'), findsOneWidget);
    expect(find.text('Editar evaluación'), findsOneWidget);
    expect(find.text('Ánimo: Bien · Satisfacción: Mucho'), findsOneWidget);
  });

  testWidgets('pide las dos calificaciones antes de guardar', (tester) async {
    final api = FakeSelfAssessmentApi();
    await openSelfAssessment(tester, api);

    await tapVisible(tester, find.text('Evaluar mi semana'));
    await tapVisible(tester, find.text('Guardar evaluación'));

    expect(find.text('Elige cómo estuvo tu ánimo'), findsOneWidget);
    expect(find.text('Elige qué tan satisfecho estás'), findsOneWidget);
    expect(api.saved, isEmpty);
  });

  testWidgets('una semana ya evaluada se edita en lugar de duplicarse', (
    tester,
  ) async {
    final api = FakeSelfAssessmentApi(
      assessments: [assessment(monday, 2, 3, note: 'Semana pesada')],
    );
    await openSelfAssessment(tester, api);

    expect(find.text('Evaluar mi semana'), findsNothing);
    await tapVisible(tester, find.text('Editar evaluación'));

    expect(find.text('Editar evaluación'), findsOneWidget);
    expect(find.text('2 · Mal'), findsOneWidget);
    expect(find.text('Semana pesada'), findsOneWidget);

    await tapVisible(tester, find.text('4').first);
    await tapVisible(tester, find.text('Guardar evaluación'));

    final (week, input) = api.saved.single;
    expect(Week.same(week, monday), isTrue);
    expect(input.mood, 4);
    expect(input.satisfaction, 3);
    final list = await api.list();
    expect(list, hasLength(1));
  });

  testWidgets('el historial muestra semanas anteriores y deja editarlas', (
    tester,
  ) async {
    final api = FakeSelfAssessmentApi(
      assessments: [assessment(lastMonday, 5, 4, note: 'Muy productiva')],
    );
    await openSelfAssessment(tester, api);

    expect(find.text(Week.label(lastMonday)), findsOneWidget);
    expect(find.text('Muy productiva'), findsOneWidget);

    await tapVisible(tester, find.text(Week.label(lastMonday)));
    await tapVisible(tester, find.text('Guardar evaluación'));

    final (week, _) = api.saved.single;
    expect(Week.same(week, lastMonday), isTrue);
  });

  testWidgets('si falla la carga deja reintentar', (tester) async {
    await openSelfAssessment(
      tester,
      FakeSelfAssessmentApi(listError: const NetworkException()),
    );

    expect(find.text('Reintentar'), findsOneWidget);
  });
}
