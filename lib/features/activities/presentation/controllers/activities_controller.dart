import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/features/activities/data/activities_api.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/domain/activity_filter.dart';
import 'package:kairo/features/activities/domain/activity_status.dart';
import 'package:kairo/features/home/presentation/controllers/agenda_controller.dart';

class ActivityFilterController extends Notifier<ActivityFilter> {
  @override
  ActivityFilter build() => const ActivityFilter();

  void setStatus(ActivityStatus? status) => state = state.withStatus(status);

  void setSubject(String? subjectId) => state = state.withSubject(subjectId);
}

final activityFilterProvider =
    NotifierProvider<ActivityFilterController, ActivityFilter>(
      ActivityFilterController.new,
    );

class ActivitiesController extends AsyncNotifier<List<Activity>> {
  @override
  Future<List<Activity>> build() {
    final filter = ref.watch(activityFilterProvider);
    return ref.read(activitiesApiProvider).list(filter);
  }

  Future<AppException?> toggleCompleted(String id) async {
    final previous = state.value;
    if (previous == null) {
      return null;
    }
    final index = previous.indexWhere((activity) => activity.id == id);
    if (index == -1) {
      return null;
    }

    final completing = previous[index].status != ActivityStatus.completed;
    final next = completing ? ActivityStatus.completed : ActivityStatus.pending;
    final filterStatus = ref.read(activityFilterProvider).status;
    final hide = filterStatus != null && filterStatus != next;
    final optimistic = [
      for (final activity in previous)
        if (activity.id != id)
          activity
        else if (!hide)
          activity.copyWith(status: next),
    ];
    state = AsyncData(optimistic);

    try {
      final api = ref.read(activitiesApiProvider);
      final saved = completing ? await api.complete(id) : await api.reopen(id);
      ref.invalidate(agendaProvider);
      if (ref.mounted && !hide) {
        state = AsyncData([
          for (final activity in state.value ?? optimistic)
            if (activity.id == id) saved else activity,
        ]);
      }
      return null;
    } on Exception catch (error) {
      if (ref.mounted) {
        state = AsyncData(previous);
      }
      return toAppException(error);
    }
  }
}

final activitiesControllerProvider =
    AsyncNotifierProvider<ActivitiesController, List<Activity>>(
      ActivitiesController.new,
    );
