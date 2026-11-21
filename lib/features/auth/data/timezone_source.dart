import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

class TimezoneSource {
  const TimezoneSource();

  static const fallback = 'America/Mexico_City';

  Future<String> local() async {
    try {
      final timezone = await FlutterTimezone.getLocalTimezone();
      return timezone.isEmpty ? fallback : timezone;
    } on Exception {
      return fallback;
    }
  }

  Future<List<String>> available() async {
    try {
      final timezones = await FlutterTimezone.getAvailableTimezones();
      return [...timezones]..sort();
    } on Exception {
      return const [fallback];
    }
  }
}

final timezoneSourceProvider = Provider<TimezoneSource>(
  (ref) => const TimezoneSource(),
);
