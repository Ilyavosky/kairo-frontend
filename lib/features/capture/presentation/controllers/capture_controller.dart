import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/errors/app_exception.dart';
import 'package:kairo/features/activities/presentation/controllers/activities_controller.dart';
import 'package:kairo/features/capture/data/capture_api.dart';
import 'package:kairo/features/capture/data/models/capture.dart';
import 'package:kairo/features/goals/presentation/controllers/goals_controller.dart';
import 'package:kairo/features/home/presentation/controllers/agenda_controller.dart';
import 'package:kairo/features/time_tracking/data/time_records_api.dart';

@immutable
class CaptureState {
  const CaptureState({this.capture, this.busy = false, this.error});

  final Capture? capture;
  final bool busy;
  final AppException? error;
}

class CaptureController extends Notifier<CaptureState> {
  @override
  CaptureState build() => const CaptureState();

  Future<void> submit(String text) async {
    if (state.busy) {
      return;
    }
    state = const CaptureState(busy: true);
    try {
      final capture = await ref.read(captureApiProvider).create(text.trim());
      if (ref.mounted) {
        state = CaptureState(capture: capture);
      }
    } on Exception catch (error) {
      if (ref.mounted) {
        state = CaptureState(error: toAppException(error));
      }
    }
  }

  Future<Capture?> confirm() =>
      _close((api, id) => api.confirm(id), refresh: true);

  Future<Capture?> correct(Map<String, dynamic> fields) => fields.isEmpty
      ? confirm()
      : _close((api, id) => api.correct(id, fields), refresh: true);

  Future<Capture?> discard() =>
      _close((api, id) => api.discard(id), refresh: false);

  void startOver() => state = const CaptureState();

  Future<Capture?> _close(
    Future<Capture> Function(CaptureApi api, String id) action, {
    required bool refresh,
  }) async {
    final capture = state.capture;
    if (capture == null || state.busy) {
      return null;
    }
    state = CaptureState(capture: capture, busy: true);
    try {
      final result = await action(ref.read(captureApiProvider), capture.id);
      if (refresh) {
        ref
          ..invalidate(activitiesControllerProvider)
          ..invalidate(agendaProvider)
          ..invalidate(timeRecordsProvider)
          ..invalidate(activeGoalsProvider);
      }
      if (ref.mounted) {
        state = CaptureState(capture: result);
      }
      return result;
    } on Exception catch (error) {
      if (ref.mounted) {
        state = CaptureState(capture: capture, error: toAppException(error));
      }
      return null;
    }
  }
}

final captureControllerProvider =
    NotifierProvider<CaptureController, CaptureState>(
      CaptureController.new,
      isAutoDispose: true,
    );
