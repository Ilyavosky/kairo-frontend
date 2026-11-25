import 'package:flutter_test/flutter_test.dart';
import 'package:kairo/features/time_tracking/data/models/timer_session.dart';
import 'package:kairo/features/time_tracking/domain/duration_format.dart';
import 'package:kairo/features/time_tracking/domain/running_timer.dart';

void main() {
  test('formato de reloj con horas, minutos y segundos', () {
    expect(DurationFormat.clock(Duration.zero), '00:00:00');
    expect(DurationFormat.clock(const Duration(seconds: 3725)), '01:02:05');
    expect(DurationFormat.clock(const Duration(hours: 12)), '12:00:00');
  });

  test('formato corto para los avisos y la lista', () {
    expect(DurationFormat.short(const Duration(seconds: 40)), '40 s');
    expect(DurationFormat.short(const Duration(minutes: 25)), '25 min');
    expect(DurationFormat.short(const Duration(hours: 2)), '2 h');
    expect(
      DurationFormat.short(const Duration(hours: 1, minutes: 23)),
      '1 h 23 min',
    );
  });

  test('el tiempo parte de lo que dijo el servidor, no del reloj local', () {
    final syncedAt = DateTime(2026, 11, 24, 20);
    final running = RunningTimer(
      session: TimerSession(
        id: 'sesion-1',
        categoryId: 'categoria-1',
        startedAt: DateTime(2026, 11, 24, 12),
        elapsedSeconds: 600,
      ),
      syncedAt: syncedAt,
    );

    expect(
      running.elapsedAt(syncedAt.add(const Duration(seconds: 30))),
      const Duration(seconds: 630),
    );
    expect(
      running.elapsedAt(syncedAt.subtract(const Duration(seconds: 5))),
      const Duration(seconds: 600),
    );
  });
}
