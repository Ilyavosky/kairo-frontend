import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/features/self_assessment/domain/self_assessment_scale.dart';
import 'package:kairo/features/self_assessment/domain/week.dart';

void main() {
  test('cualquier día de la semana apunta a su lunes', () {
    expect(Week.mondayOf(DateTime(2026, 11, 26, 22)), DateTime(2026, 11, 23));
    expect(Week.mondayOf(DateTime(2026, 11, 23)), DateTime(2026, 11, 23));
    expect(
      Week.mondayOf(DateTime(2026, 11, 29, 23, 59)),
      DateTime(2026, 11, 23),
    );
    expect(Week.mondayOf(DateTime(2026, 12, 2)), DateTime(2026, 11, 30));
  });

  test('la semana viaja a la API como fecha del lunes', () {
    expect(Week.key(DateTime(2026, 11, 2)), '2026-11-02');
    expect(Week.parse('2026-11-23'), DateTime(2026, 11, 23));
    expect(Week.parse('no es fecha'), isNull);
  });

  test('muestra el rango de lunes a domingo', () {
    expect(Week.label(DateTime(2026, 11, 23)), 'Lun 23 nov – Dom 29 nov');
  });

  test('resume el ánimo y la satisfacción con sus etiquetas', () {
    expect(
      SelfAssessmentScale.summary(4, 2),
      'Ánimo: Bien · Satisfacción: Poco',
    );
    expect(SelfAssessmentScale.level(null, 'Elige'), 'Elige');
    expect(SelfAssessmentScale.level(3, 'Elige'), isNull);
    expect(SelfAssessmentScale.note('a' * 2001), isNotNull);
  });
}
