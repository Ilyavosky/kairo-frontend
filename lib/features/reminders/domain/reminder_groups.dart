import 'package:kairo/features/reminders/data/models/reminder.dart';
import 'package:kairo/features/reminders/domain/reminder_status.dart';
import 'package:kairo/features/reminders/domain/reminder_target.dart';

extension ReminderDetails on Reminder {
  ReminderTarget get target {
    if (activityId != null) {
      return ReminderTarget.activity;
    }
    if (eventId != null) {
      return ReminderTarget.event;
    }
    return ReminderTarget.goal;
  }

  String? get targetId => activityId ?? eventId ?? goalId;
}

abstract final class ReminderGroups {
  static List<Reminder> upcoming(List<Reminder> reminders) => [
    for (final reminder in reminders)
      if (reminder.status == ReminderStatus.pending) reminder,
  ]..sort((a, b) => a.moment.compareTo(b.moment));

  static List<Reminder> past(List<Reminder> reminders) => [
    for (final reminder in reminders)
      if (reminder.status != ReminderStatus.pending) reminder,
  ]..sort((a, b) => _when(b).compareTo(_when(a)));

  static DateTime _when(Reminder reminder) =>
      reminder.sentAt ?? reminder.moment;
}
