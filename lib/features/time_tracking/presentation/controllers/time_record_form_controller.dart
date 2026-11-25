import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/features/time_tracking/data/models/time_record_input.dart';
import 'package:kairo/features/time_tracking/data/time_records_api.dart';

class TimeRecordFormController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<bool> save({required TimeRecordInput input, String? recordId}) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      final api = ref.read(timeRecordsApiProvider);
      if (recordId == null) {
        await api.create(input);
      } else {
        await api.update(recordId, input);
      }
      ref.invalidate(timeRecordsProvider);
    });
    if (ref.mounted) {
      state = result;
    }
    return !result.hasError;
  }
}

final timeRecordFormControllerProvider =
    AsyncNotifierProvider<TimeRecordFormController, void>(
      TimeRecordFormController.new,
      isAutoDispose: true,
    );
