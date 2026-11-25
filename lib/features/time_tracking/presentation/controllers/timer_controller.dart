import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/features/time_tracking/data/models/time_record.dart';
import 'package:kairo/features/time_tracking/data/models/timer_session.dart';
import 'package:kairo/features/time_tracking/data/time_records_api.dart';
import 'package:kairo/features/time_tracking/data/timer_api.dart';
import 'package:kairo/features/time_tracking/domain/running_timer.dart';

typedef StopResult = ({TimeRecord? record, AppException? error});

class TimerController extends AsyncNotifier<TimerStatus> {
  @override
  Future<TimerStatus> build() async {
    final session = await ref.read(timerApiProvider).current();
    return TimerStatus(running: _running(session));
  }

  Future<void> refresh() async {
    final previous = state.value;
    try {
      final session = await ref.read(timerApiProvider).current();
      if (ref.mounted) {
        state = AsyncData(TimerStatus(running: _running(session)));
      }
    } on Exception catch (error, stackTrace) {
      if (!ref.mounted) {
        return;
      }
      state = previous == null
          ? AsyncError(error, stackTrace)
          : AsyncData(TimerStatus(running: previous.running, offline: true));
    }
  }

  Future<AppException?> start({
    required String categoryId,
    String? activityId,
  }) async {
    try {
      final session = await ref
          .read(timerApiProvider)
          .start(categoryId: categoryId, activityId: activityId);
      if (ref.mounted) {
        state = AsyncData(TimerStatus(running: _running(session)));
      }
      return null;
    } on Exception catch (error) {
      return toAppException(error);
    }
  }

  Future<StopResult> stop({String? note}) async {
    try {
      final record = await ref.read(timerApiProvider).stop(note: note);
      ref.invalidate(timeRecordsProvider);
      if (ref.mounted) {
        state = const AsyncData(TimerStatus());
      }
      return (record: record, error: null);
    } on Exception catch (error) {
      final previous = state.value;
      if (ref.mounted && previous != null) {
        state = AsyncData(
          TimerStatus(running: previous.running, offline: true),
        );
      }
      return (record: null, error: toAppException(error));
    }
  }

  RunningTimer? _running(TimerSession? session) => session == null
      ? null
      : RunningTimer(session: session, syncedAt: DateTime.now());
}

final timerControllerProvider =
    AsyncNotifierProvider<TimerController, TimerStatus>(TimerController.new);
