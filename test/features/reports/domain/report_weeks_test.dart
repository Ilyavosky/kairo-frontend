import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/features/reports/data/models/rest_week.dart';
import 'package:kairo/features/reports/data/models/weekly_load.dart';
import 'package:kairo/features/reports/domain/report_weeks.dart';

void main() {
  final week1 = DateTime(2026, 11, 9);
  final week2 = DateTime(2026, 11, 16);
  final week3 = DateTime(2026, 11, 23);

  WeeklyLoad load(
    DateTime week,
    String? subject,
    int deliveries, {
    int pending = 0,
    double minutes = 0,
  }) => WeeklyLoad(
    weekStart: week,
    subject: subject,
    deliveries: deliveries,
    pending: pending,
    minutes: minutes,
  );

  RestWeek rest(DateTime week, double sleep, double exercise) => RestWeek(
    weekStart: week,
    academicMinutes: 0,
    sleepMinutes: sleep,
    exerciseMinutes: exercise,
  );

  final loads = [
    load(week2, 'Redes', 2, pending: 1, minutes: 150),
    load(week2, 'Cálculo', 3),
    load(week2, null, 0, minutes: 45),
    load(week3, 'Redes', 1),
    load(week1, 'IA', 0),
  ];

  test('las materias de la semana usan las cifras de la API', () {
    final items = ReportWeeks.subjects(loads, week2);

    expect(items.map((i) => i.name), ['Cálculo', 'Redes', 'Sin materia']);
    expect(items[1].deliveries, 2);
    expect(items[1].pending, 1);
    expect(items[1].minutes, 150);
  });

  test('omite materias sin entregas ni tiempo', () {
    expect(ReportWeeks.subjects(loads, week1), isEmpty);
  });

  test('la tendencia suma las entregas de cada semana', () {
    final trend = ReportWeeks.trend(loads, [
      rest(week3, 2940, 60),
      rest(week2, 3360, 180),
    ], DateTime(2027));

    expect(trend.map((t) => t.weekStart), [week2, week3]);
    expect(trend.first.deliveries, 5);
    expect(trend.first.sleepHoursPerNight, 8);
    expect(trend.first.exerciseHours, 3);
    expect(trend.last.deliveries, 1);
  });

  test('la semana en curso promedia el sueño solo con los días que van', () {
    final trend = ReportWeeks.trend(loads, [
      rest(week3, 1260, 0),
    ], DateTime(2026, 11, 25, 20));

    expect(trend.single.days, 3);
    expect(trend.single.inProgress, isTrue);
    expect(trend.single.sleepHoursPerNight, 7);
  });

  test('pide al menos tres semanas para la tendencia', () {
    expect(
      ReportWeeks.enoughData([rest(week1, 1, 1), rest(week2, 1, 1)]),
      isFalse,
    );
    expect(
      ReportWeeks.enoughData([
        rest(week1, 1, 1),
        rest(week2, 1, 1),
        rest(week3, 1, 1),
      ]),
      isTrue,
    );
  });

  test('las semanas disponibles incluyen la actual y van en orden', () {
    final weeks = ReportWeeks.available(loads, [
      rest(week1, 1, 1),
    ], DateTime(2026, 12, 2));

    expect(weeks, [week1, week2, week3, DateTime(2026, 11, 30)]);
  });

  test('formatea horas y minutos sin inventar cifras', () {
    expect(ReportWeeks.minutes(150), '2 h 30 min');
    expect(ReportWeeks.minutes(45), '45 min');
    expect(ReportWeeks.minutes(0), '0 min');
    expect(ReportWeeks.hours(7.5), '7.5 h');
    expect(ReportWeeks.hours(3), '3 h');
    expect(ReportWeeks.deliveries(1), '1 entrega');
  });
}
