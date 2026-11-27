import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/features/reminders/data/models/reminder_input.dart';
import 'package:kairo/features/reminders/data/reminders_api.dart';
import 'package:kairo/features/reminders/presentation/controllers/reminder_form_controller.dart';
import 'package:kairo/features/reminders/presentation/controllers/reminders_controller.dart';

import '../../../helpers/fake_reminders_api.dart';

void main() {
  final input = ReminderInput(
    moment: DateTime.utc(2026, 11, 27, 14),
    eventId: 'evento-1',
  );

  ProviderContainer containerWith(FakeRemindersApi api) {
    final container = ProviderContainer(
      overrides: [remindersApiProvider.overrideWithValue(api)],
    );
    addTearDown(container.dispose);
    container.listen(reminderFormControllerProvider, (_, _) {});
    return container;
  }

  test('crea el recordatorio y aparece en la lista', () async {
    final api = FakeRemindersApi();
    final container = containerWith(api);

    final saved = await container
        .read(reminderFormControllerProvider.notifier)
        .create(input);

    expect(saved, isTrue);
    expect(api.created.single.eventId, 'evento-1');
    expect(api.created.single.activityId, isNull);
    final reminders = await container.read(remindersProvider.future);
    expect(reminders.single.eventId, 'evento-1');
  });

  test('si la API rechaza el recordatorio deja el error', () async {
    final api = FakeRemindersApi(
      createError: const ValidationException('La fecha debe ser futura'),
    );
    final container = containerWith(api);

    final saved = await container
        .read(reminderFormControllerProvider.notifier)
        .create(input);

    expect(saved, isFalse);
    final error = container.read(reminderFormControllerProvider).error;
    expect(error, isA<ValidationException>());
  });
}
