import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/features/activities/data/categories_api.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';
import 'package:kairo/features/activities/domain/due_label.dart';
import 'package:kairo/features/events/data/events_api.dart';
import 'package:kairo/features/events/data/models/event.dart';
import 'package:kairo/features/goals/data/goals_api.dart';
import 'package:kairo/features/goals/data/models/goal.dart';
import 'package:kairo/features/goals/domain/goal_format.dart';
import 'package:kairo/features/reminders/data/models/reminder.dart';
import 'package:kairo/features/reminders/data/reminders_api.dart';
import 'package:kairo/features/reminders/domain/reminder_option.dart';
import 'package:kairo/features/reminders/domain/reminder_target.dart';
import 'package:kairo/features/time_tracking/presentation/controllers/timer_options.dart';

final remindersProvider = FutureProvider<List<Reminder>>(
  (ref) => ref.watch(remindersApiProvider).list(),
);

final upcomingEventsProvider = FutureProvider<List<Event>>((ref) {
  final now = DateTime.now();
  return ref
      .watch(eventsApiProvider)
      .list(from: DateTime(now.year, now.month, now.day));
}, isAutoDispose: true);

final reminderGoalsProvider = FutureProvider<List<Goal>>(
  (ref) => ref.watch(goalsApiProvider).list(active: true),
  isAutoDispose: true,
);

final reminderOptionsProvider =
    Provider<Map<ReminderTarget, List<ReminderOption>>>((ref) {
      final activities =
          ref.watch(openActivitiesProvider).value ?? const <Activity>[];
      final events = ref.watch(upcomingEventsProvider).value ?? const <Event>[];
      final goals = ref.watch(reminderGoalsProvider).value ?? const <Goal>[];
      final categories =
          ref.watch(categoriesProvider).value ?? const <ActivityCategory>[];
      final categoryNames = {
        for (final category in categories) category.id: category.name,
      };
      return {
        ReminderTarget.activity: [
          for (final activity in activities)
            ReminderOption(activity.id, activity.title),
        ],
        ReminderTarget.event: [
          for (final event in events)
            ReminderOption(event.id, event.title, detail: _eventDate(event)),
        ],
        ReminderTarget.goal: [
          for (final goal in goals)
            ReminderOption(goal.id, _goalLabel(goal, categoryNames)),
        ],
      };
    }, isAutoDispose: true);

String _eventDate(Event event) {
  final start = event.start.toLocal();
  return '${DueLabel.shortDate(start)}, ${DueLabel.hour(start)}';
}

String _goalLabel(Goal goal, Map<String, String> categoryNames) {
  final category = categoryNames[goal.categoryId] ?? 'Meta';
  final amount = GoalFormat.amount(goal.type, goal.target);
  return '$category · $amount, ${goal.period.label.toLowerCase()}';
}
