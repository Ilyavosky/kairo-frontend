import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/features/activities/data/activities_api.dart';
import 'package:kairo/features/home/data/calendar_api.dart';
import 'package:kairo/features/home/domain/agenda.dart';

final agendaProvider = FutureProvider<List<AgendaDay>>((ref) async {
  final now = DateTime.now();
  final activities = await ref
      .watch(activitiesApiProvider)
      .listDueBetween(Agenda.startOf(now), Agenda.endOf(now));
  final events = await ref.watch(calendarApiProvider).list();
  return Agenda.build(now: now, activities: activities, events: events);
});
