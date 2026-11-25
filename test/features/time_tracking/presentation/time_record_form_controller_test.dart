import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/features/time_tracking/data/models/time_record.dart';
import 'package:kairo/features/time_tracking/data/models/time_record_input.dart';
import 'package:kairo/features/time_tracking/data/time_records_api.dart';
import 'package:kairo/features/time_tracking/presentation/controllers/time_record_form_controller.dart';

import '../../../helpers/fake_time_records_api.dart';

void main() {
  final input = TimeRecordInput(
    categoryId: 'categoria-sueno',
    start: DateTime.utc(2026, 11, 24, 5),
    end: DateTime.utc(2026, 11, 24, 13),
  );

  ProviderContainer containerWith(FakeTimeRecordsApi api) {
    final container = ProviderContainer(
      overrides: [timeRecordsApiProvider.overrideWithValue(api)],
    );
    addTearDown(container.dispose);
    container.listen(timeRecordFormControllerProvider, (_, _) {});
    return container;
  }

  test('sin id crea un registro manual nuevo', () async {
    final api = FakeTimeRecordsApi();
    final container = containerWith(api);

    final saved = await container
        .read(timeRecordFormControllerProvider.notifier)
        .save(input: input);

    expect(saved, isTrue);
    expect(api.created.single.categoryId, 'categoria-sueno');
    final records = await container.read(timeRecordsProvider.future);
    expect(records.single.origin, 'manual');
    expect(records.single.duration, const Duration(hours: 8));
  });

  test('con id actualiza el registro existente', () async {
    final api = FakeTimeRecordsApi(
      records: [
        TimeRecord(
          id: 'r1',
          categoryId: 'categoria-estudio',
          start: DateTime.utc(2026, 11, 24, 15),
          end: DateTime.utc(2026, 11, 24, 16),
          origin: 'temporizador',
        ),
      ],
    );
    final container = containerWith(api);

    final saved = await container
        .read(timeRecordFormControllerProvider.notifier)
        .save(recordId: 'r1', input: input);

    expect(saved, isTrue);
    expect(api.updated['r1']?.categoryId, 'categoria-sueno');
    expect(api.created, isEmpty);
  });

  test('si falla el guardado lo reporta', () async {
    final api = FakeTimeRecordsApi(saveError: const NetworkException());
    final container = containerWith(api);

    final saved = await container
        .read(timeRecordFormControllerProvider.notifier)
        .save(input: input);

    expect(saved, isFalse);
    expect(
      container.read(timeRecordFormControllerProvider).error,
      isA<NetworkException>(),
    );
  });
}
