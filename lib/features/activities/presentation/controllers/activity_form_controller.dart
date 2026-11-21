import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/features/activities/data/activities_api.dart';
import 'package:kairo/features/activities/data/models/activity_input.dart';
import 'package:kairo/features/activities/presentation/controllers/activities_controller.dart';

class ActivityFormController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<bool> save({required ActivityInput input, String? activityId}) {
    return _run(() async {
      final api = ref.read(activitiesApiProvider);
      if (activityId == null) {
        await api.create(input);
      } else {
        await api.update(activityId, input);
      }
    });
  }

  Future<bool> setCompleted(String activityId, {required bool completed}) {
    return _run(() async {
      final api = ref.read(activitiesApiProvider);
      if (completed) {
        await api.complete(activityId);
      } else {
        await api.reopen(activityId);
      }
    });
  }

  Future<bool> _run(Future<void> Function() action) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      await action();
      ref.invalidate(activitiesControllerProvider);
    });
    if (ref.mounted) {
      state = result;
    }
    return !result.hasError;
  }
}

final activityFormControllerProvider =
    AsyncNotifierProvider<ActivityFormController, void>(
      ActivityFormController.new,
      isAutoDispose: true,
    );
