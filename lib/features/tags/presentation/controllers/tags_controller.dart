import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:kairo/features/tags/data/models/tag.dart';
import 'package:kairo/features/tags/data/tags_api.dart';

final tagsProvider = FutureProvider<List<Tag>>(
  (ref) => ref.watch(tagsApiProvider).list(),
  isAutoDispose: true,
);

final FutureProviderFamily<List<Tag>, String> activityTagsProvider =
    FutureProvider.family<List<Tag>, String>(
      (ref, activityId) => ref.watch(tagsApiProvider).ofActivity(activityId),
      isAutoDispose: true,
    );

class ActivityTagsController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<bool> assign(String activityId, String tagId) => _run(
    activityId,
    () => ref.read(tagsApiProvider).assign(activityId, tagId),
  );

  Future<bool> remove(String activityId, String tagId) => _run(
    activityId,
    () => ref.read(tagsApiProvider).remove(activityId, tagId),
  );

  Future<bool> createAndAssign(String activityId, String name) =>
      _run(activityId, () async {
        final api = ref.read(tagsApiProvider);
        final tag = await api.create(name.trim());
        await api.assign(activityId, tag.id);
      });

  Future<bool> _run(String activityId, Future<void> Function() action) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      await action();
      ref
        ..invalidate(tagsProvider)
        ..invalidate(activityTagsProvider(activityId));
    });
    if (ref.mounted) {
      state = result;
    }
    return !result.hasError;
  }
}

final activityTagsControllerProvider =
    AsyncNotifierProvider<ActivityTagsController, void>(
      ActivityTagsController.new,
      isAutoDispose: true,
    );
