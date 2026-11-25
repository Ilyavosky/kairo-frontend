import 'package:flutter/material.dart';
import 'package:kairo/features/activities/domain/due_label.dart';

Future<DateTime?> pickDateTime(
  BuildContext context, {
  required DateTime initial,
  required String title,
}) async {
  final now = DateTime.now();
  final first = DateTime(now.year - 1);
  final date = await showDatePicker(
    context: context,
    initialDate: initial.isBefore(first) ? first : initial,
    firstDate: first,
    lastDate: now,
    helpText: title,
  );
  if (date == null || !context.mounted) {
    return null;
  }
  final time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(initial),
    helpText: title,
  );
  if (time == null) {
    return null;
  }
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}

String dateTimeLabel(DateTime value) =>
    '${DueLabel.shortDate(value)}, ${DueLabel.hour(value)}';
