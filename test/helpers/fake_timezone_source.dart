import 'package:kairo/features/auth/data/timezone_source.dart';

class FakeTimezoneSource implements TimezoneSource {
  const FakeTimezoneSource({
    this.localTimezone = 'America/Mexico_City',
    this.availableTimezones = const [
      'America/Cancun',
      'America/Mexico_City',
      'America/Tijuana',
    ],
  });

  final String localTimezone;
  final List<String> availableTimezones;

  @override
  Future<String> local() async => localTimezone;

  @override
  Future<List<String>> available() async => availableTimezones;
}
