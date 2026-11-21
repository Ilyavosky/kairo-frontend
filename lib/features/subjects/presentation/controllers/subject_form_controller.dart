import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/features/subjects/data/models/subject_input.dart';
import 'package:kairo/features/subjects/data/subjects_api.dart';

class SubjectFormController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<bool> save({required SubjectInput input, String? subjectId}) {
    return _run(() async {
      final api = ref.read(subjectsApiProvider);
      if (subjectId == null) {
        await api.create(input);
      } else {
        await api.update(subjectId, input);
      }
    });
  }

  Future<bool> archive(String subjectId) {
    return _run(() async {
      await ref.read(subjectsApiProvider).archive(subjectId);
    });
  }

  Future<bool> _run(Future<void> Function() action) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      await action();
      ref.invalidate(subjectsProvider);
    });
    if (ref.mounted) {
      state = result;
    }
    return !result.hasError;
  }
}

final subjectFormControllerProvider =
    AsyncNotifierProvider<SubjectFormController, void>(
      SubjectFormController.new,
      isAutoDispose: true,
    );
