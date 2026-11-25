import 'package:kairo/features/time_tracking/data/models/time_record.dart';
import 'package:kairo/features/time_tracking/data/models/timer_session.dart';
import 'package:kairo/features/time_tracking/data/timer_api.dart';

class FakeTimerApi implements TimerApi {
  FakeTimerApi({
    this.running,
    this.currentError,
    this.stopError,
    this.startedElsewhere,
  });

  TimerSession? running;
  TimerSession? startedElsewhere;
  Exception? currentError;
  Exception? stopError;
  final List<({String categoryId, String? activityId})> started = [];
  final List<String?> stopNotes = [];

  @override
  Future<TimerSession?> current() async {
    final error = currentError;
    if (error != null) {
      throw error;
    }
    return running;
  }

  @override
  Future<TimerStart> start({
    required String categoryId,
    String? activityId,
  }) async {
    started.add((categoryId: categoryId, activityId: activityId));
    final elsewhere = startedElsewhere ?? running;
    if (elsewhere != null) {
      running = elsewhere;
      return (session: elsewhere, alreadyRunning: true);
    }
    final session = TimerSession(
      id: 'sesion-${started.length}',
      categoryId: categoryId,
      activityId: activityId,
      startedAt: DateTime.now(),
      elapsedSeconds: 0,
    );
    running = session;
    return (session: session, alreadyRunning: false);
  }

  @override
  Future<TimeRecord?> stop({String? note}) async {
    stopNotes.add(note);
    final error = stopError;
    if (error != null) {
      throw error;
    }
    final session = running;
    if (session == null) {
      return null;
    }
    running = null;
    return TimeRecord(
      id: 'registro-${stopNotes.length}',
      categoryId: session.categoryId,
      activityId: session.activityId,
      start: session.startedAt,
      end: session.startedAt.add(Duration(seconds: session.elapsedSeconds)),
      origin: 'temporizador',
      note: note,
    );
  }
}
