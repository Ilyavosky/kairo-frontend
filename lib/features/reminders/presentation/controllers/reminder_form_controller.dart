import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/features/reminders/data/models/reminder_input.dart';
import 'package:kairo/features/reminders/data/reminders_api.dart';
import 'package:kairo/features/reminders/presentation/controllers/reminders_controller.dart';

class ReminderFormController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<bool> create(ReminderInput input) =>
      _run(() => ref.read(remindersApiProvider).create(input));

  Future<bool> cancel(String reminderId) =>
      _run(() => ref.read(remindersApiProvider).cancel(reminderId));

  Future<bool> _run(Future<void> Function() action) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      await action();
      ref.invalidate(remindersProvider);
    });
    if (ref.mounted) {
      state = result;
    }
    return !result.hasError;
  }
}

final reminderFormControllerProvider =
    AsyncNotifierProvider<ReminderFormController, void>(
      ReminderFormController.new,
      isAutoDispose: true,
    );
