import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/features/subjects/domain/subject_validator.dart';

void main() {
  test('pide nombre y periodo', () {
    expect(SubjectValidator.name(' '), 'Escribe el nombre de la materia');
    expect(SubjectValidator.period(''), 'Escribe el periodo de la materia');
  });

  test('limita los textos a 120 caracteres', () {
    expect(SubjectValidator.name('a' * 121), isNotNull);
    expect(SubjectValidator.optional('a' * 121), isNotNull);
    expect(SubjectValidator.optional(''), isNull);
  });

  test('convierte textos vacíos en null', () {
    expect(SubjectValidator.clean('  '), isNull);
    expect(SubjectValidator.clean(' SEG-701 '), 'SEG-701');
  });
}
