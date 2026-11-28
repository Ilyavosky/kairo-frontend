import 'package:flutter/foundation.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/events/data/models/event.dart';
import 'package:kairo/features/home/data/models/calendar_event.dart';

@immutable
class AgendaDay {
  const AgendaDay({
    required this.date,
    required this.activities,
    required this.events,
    this.personalEvents = const [],
  });

  final DateTime date;
  final List<Activity> activities;
  final List<CalendarEvent> events;
  final List<Event> personalEvents;

  bool get isEmpty =>
      activities.isEmpty && events.isEmpty && personalEvents.isEmpty;
}

abstract final class Agenda {
  static const days = 7;

  static const Map<String, String> eventLabels = {
    'inicio_periodo': 'Inicio de periodo',
    'fin_periodo': 'Fin de periodo',
    'inhabil': 'Día inhábil',
    'examen': 'Exámenes',
    'institucional': 'Evento institucional',
  };

  static const _weekdays = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo',
  ];

  static DateTime startOf(DateTime now) =>
      DateTime(now.year, now.month, now.day);

  static DateTime endOf(DateTime now) {
    final start = startOf(now);
    return DateTime(start.year, start.month, start.day + days);
  }

  static List<AgendaDay> build({
    required DateTime now,
    required List<Activity> activities,
    required List<CalendarEvent> events,
    List<Event> personalEvents = const [],
  }) {
    final start = startOf(now);
    return [
      for (var offset = 0; offset < days; offset++)
        _day(
          DateTime(start.year, start.month, start.day + offset),
          activities,
          events,
          personalEvents,
        ),
    ];
  }

  static bool isNear(DateTime date, DateTime now) =>
      startOf(date).difference(startOf(now)).inDays < 2;

  static String dayTitle(DateTime date, DateTime now) {
    final offset = startOf(date).difference(startOf(now)).inDays;
    return switch (offset) {
      0 => 'Hoy',
      1 => 'Mañana',
      _ => _weekdays[date.weekday - 1],
    };
  }

  static AgendaDay _day(
    DateTime date,
    List<Activity> activities,
    List<CalendarEvent> events,
    List<Event> personalEvents,
  ) {
    final dayPersonal = [
      for (final event in personalEvents)
        if (!date.isBefore(startOf(event.start.toLocal())) &&
            !date.isAfter(startOf(event.end.toLocal())))
          event,
    ]..sort((a, b) => a.start.compareTo(b.start));
    final dayActivities = [
      for (final activity in activities)
        if (activity.status.isOpen && _isOn(activity.dueAt, date)) activity,
    ]..sort((a, b) => a.dueAt!.compareTo(b.dueAt!));

    return AgendaDay(
      date: date,
      activities: dayActivities,
      events: [
        for (final event in events)
          if (!date.isBefore(startOf(event.date)) &&
              !date.isAfter(startOf(event.endDate ?? event.date)))
            event,
      ],
      personalEvents: dayPersonal,
    );
  }

  static bool _isOn(DateTime? dueAt, DateTime date) {
    if (dueAt == null) {
      return false;
    }
    final local = dueAt.toLocal();
    return local.year == date.year &&
        local.month == date.month &&
        local.day == date.day;
  }
}
