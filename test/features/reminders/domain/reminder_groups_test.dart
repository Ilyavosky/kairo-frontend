import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/features/reminders/data/models/reminder.dart';
import 'package:kairo/features/reminders/domain/reminder_groups.dart';
import 'package:kairo/features/reminders/domain/reminder_status.dart';
import 'package:kairo/features/reminders/domain/reminder_target.dart';
import 'package:kairo/features/reminders/domain/reminder_validator.dart';

void main() {
  Reminder reminder(
    String id,
    DateTime moment,
    ReminderStatus status, {
    DateTime? sentAt,
  }) => Reminder(
    id: id,
    moment: moment,
    status: status,
    createdAt: DateTime(2026, 11, 20),
    goalId: 'meta-1',
    sentAt: sentAt,
  );

  final reminders = [
    reminder('tarde', DateTime(2026, 11, 28, 18), ReminderStatus.pending),
    reminder('temprano', DateTime(2026, 11, 27, 8), ReminderStatus.pending),
    reminder(
      'enviado',
      DateTime(2026, 11, 24, 9),
      ReminderStatus.sent,
      sentAt: DateTime(2026, 11, 24, 9, 2),
    ),
    reminder('fallido', DateTime(2026, 11, 25, 9), ReminderStatus.failed),
    reminder('cancelado', DateTime(2026, 11, 23, 9), ReminderStatus.cancelled),
  ];

  test('próximos son los pendientes del más cercano al más lejano', () {
    expect(ReminderGroups.upcoming(reminders).map((r) => r.id), [
      'temprano',
      'tarde',
    ]);
  });

  test('enviados incluye los cerrados del más reciente al más viejo', () {
    expect(ReminderGroups.past(reminders).map((r) => r.id), [
      'fallido',
      'enviado',
      'cancelado',
    ]);
  });

  test('identifica a qué apunta cada recordatorio', () {
    final activity = reminder(
      'a',
      DateTime(2026, 11, 27),
      ReminderStatus.pending,
    ).copyWith(goalId: null, activityId: 'actividad-1');

    expect(activity.target, ReminderTarget.activity);
    expect(activity.targetId, 'actividad-1');
    expect(reminders.first.target, ReminderTarget.goal);
  });

  test('valida el destino y que el aviso sea futuro', () {
    final now = DateTime(2026, 11, 26, 12);

    expect(ReminderValidator.target(null), isNotNull);
    expect(ReminderValidator.target('meta-1'), isNull);
    expect(ReminderValidator.moment(null, now), isNotNull);
    expect(
      ReminderValidator.moment(DateTime(2026, 11, 26, 11), now),
      isNotNull,
    );
    expect(ReminderValidator.moment(DateTime(2026, 11, 26, 13), now), isNull);
  });
}
