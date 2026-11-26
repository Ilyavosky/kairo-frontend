import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/features/goals/domain/goal_format.dart';
import 'package:kairo/features/goals/domain/goal_period.dart';
import 'package:kairo/features/goals/domain/goal_type.dart';

void main() {
  test('muestra minutos como horas y eventos como registros', () {
    expect(GoalFormat.amount(GoalType.time, 90), '1 h 30 min');
    expect(GoalFormat.amount(GoalType.time, 44.6), '45 min');
    expect(GoalFormat.amount(GoalType.time, 0), '0 min');
    expect(GoalFormat.amount(GoalType.events, 1), '1 registro');
    expect(GoalFormat.progress(GoalType.events, 2, 5), '2 de 5 registros');
  });

  test('el porcentaje es el de la API y la barra no pasa de lleno', () {
    expect(GoalFormat.percent(30), '30 %');
    expect(GoalFormat.percent(37.5), '37.5 %');
    expect(GoalFormat.ratio(37.5), 0.375);
    expect(GoalFormat.ratio(140), 1);
  });

  test('describe el periodo según su tipo', () {
    expect(
      GoalFormat.periodRange(
        GoalPeriod.week,
        DateTime(2026, 11, 23),
        DateTime(2026, 11, 30),
      ),
      '23 nov – 29 nov',
    );
    expect(
      GoalFormat.periodRange(
        GoalPeriod.month,
        DateTime(2026, 11),
        DateTime(2026, 12),
      ),
      'Noviembre 2026',
    );
    expect(
      GoalFormat.periodRange(
        GoalPeriod.day,
        DateTime(2026, 11, 25),
        DateTime(2026, 11, 26),
      ),
      'Mié 25 nov',
    );
  });
}
