import 'package:kairo/features/reminders/data/models/reminder.dart';
import 'package:kairo/features/reminders/data/models/reminder_input.dart';
import 'package:kairo/features/reminders/data/reminders_api.dart';
import 'package:kairo/features/reminders/domain/reminder_status.dart';

class FakeRemindersApi implements RemindersApi {
  FakeRemindersApi({
    List<Reminder> reminders = const [],
    this.listError,
    this.createError,
  }) : _reminders = [...reminders];

  final List<Reminder> _reminders;
  final Exception? listError;
  final Exception? createError;
  final List<ReminderInput> created = [];
  final List<String> cancelled = [];
  var _nextId = 1;

  @override
  Future<List<Reminder>> list() async {
    final error = listError;
    if (error != null) {
      throw error;
    }
    return [..._reminders];
  }

  @override
  Future<Reminder> create(ReminderInput input) async {
    created.add(input);
    final error = createError;
    if (error != null) {
      throw error;
    }
    final reminder = Reminder(
      id: 'recordatorio-nuevo-${_nextId++}',
      moment: input.moment,
      status: ReminderStatus.pending,
      createdAt: DateTime.now(),
      activityId: input.activityId,
      eventId: input.eventId,
      goalId: input.goalId,
    );
    _reminders.add(reminder);
    return reminder;
  }

  @override
  Future<Reminder> cancel(String reminderId) async {
    cancelled.add(reminderId);
    final index = _reminders.indexWhere((r) => r.id == reminderId);
    final updated = _reminders[index].copyWith(
      status: ReminderStatus.cancelled,
    );
    _reminders[index] = updated;
    return updated;
  }
}
