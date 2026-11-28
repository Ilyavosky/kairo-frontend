import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/domain/activity_modality.dart';
import 'package:kairo/features/activities/domain/activity_status.dart';
import 'package:kairo/features/events/data/models/event.dart';
import 'package:kairo/features/events/domain/event_type.dart';
import 'package:kairo/features/home/data/models/calendar_event.dart';
import 'package:kairo/features/home/domain/agenda.dart';

void main() {
  final now = DateTime(2026, 11, 20, 10);

  Activity activity(
    String id,
    DateTime? dueAt, {
    ActivityStatus status = ActivityStatus.pending,
  }) => Activity(
    id: id,
    categoryId: 'categoria-1',
    title: id,
    priority: 3,
    modality: ActivityModality.inPerson,
    status: status,
    createdAt: DateTime(2026, 11),
    dueAt: dueAt,
  );

  test('arma siete días a partir de hoy', () {
    final days = Agenda.build(now: now, activities: const [], events: const []);

    expect(days, hasLength(7));
    expect(days.first.date, DateTime(2026, 11, 20));
    expect(days.last.date, DateTime(2026, 11, 26));
    expect(days.every((day) => day.isEmpty), isTrue);
  });

  test('agrupa por día, ordena por hora y omite las cerradas', () {
    final days = Agenda.build(
      now: now,
      activities: [
        activity('tarde', DateTime(2026, 11, 20, 18)),
        activity('temprano', DateTime(2026, 11, 20, 8)),
        activity('mañana', DateTime(2026, 11, 21, 9)),
        activity(
          'hecha',
          DateTime(2026, 11, 20, 12),
          status: ActivityStatus.completed,
        ),
        activity('sin fecha', null),
      ],
      events: const [],
    );

    expect(days[0].activities.map((a) => a.id), ['temprano', 'tarde']);
    expect(days[1].activities.map((a) => a.id), ['mañana']);
  });

  test('muestra los eventos del calendario en todos los días de su rango', () {
    final days = Agenda.build(
      now: now,
      activities: const [],
      events: [
        CalendarEvent(
          id: 'e1',
          period: '2026-3',
          type: 'examen',
          date: DateTime(2026, 11, 23),
          endDate: DateTime(2026, 11, 25),
          description: 'Segundo parcial',
        ),
      ],
    );

    expect([for (final day in days) day.events.length], [0, 0, 0, 1, 1, 1, 0]);
  });

  test('nombra hoy, mañana y el día de la semana', () {
    expect(Agenda.dayTitle(DateTime(2026, 11, 20), now), 'Hoy');
    expect(Agenda.dayTitle(DateTime(2026, 11, 21), now), 'Mañana');
    expect(Agenda.dayTitle(DateTime(2026, 11, 23), now), 'Lunes');
  });

  test('coloca los eventos personales en cada día que abarcan', () {
    final days = Agenda.build(
      now: now,
      activities: const [],
      events: const [],
      personalEvents: [
        Event(
          id: 'evento-1',
          title: 'Congreso',
          start: DateTime(2026, 11, 21, 9),
          end: DateTime(2026, 11, 22, 18),
          type: EventType.meeting,
        ),
      ],
    );

    expect(days[0].personalEvents, isEmpty);
    expect(days[1].personalEvents.single.title, 'Congreso');
    expect(days[2].personalEvents.single.title, 'Congreso');
    expect(days[3].personalEvents, isEmpty);
    expect(days[1].isEmpty, isFalse);
  });
}
