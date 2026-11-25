import 'package:flutter/foundation.dart';
import 'package:kairo/features/time_tracking/data/models/timer_session.dart';

@immutable
class RunningTimer {
  const RunningTimer({required this.session, required this.syncedAt});

  final TimerSession session;
  final DateTime syncedAt;

  Duration elapsedAt(DateTime now) {
    final sinceSync = now.difference(syncedAt);
    return Duration(seconds: session.elapsedSeconds) +
        (sinceSync.isNegative ? Duration.zero : sinceSync);
  }
}

@immutable
class TimerStatus {
  const TimerStatus({this.running, this.offline = false});

  final RunningTimer? running;
  final bool offline;
}
