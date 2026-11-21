import 'package:kairo/features/home/data/calendar_api.dart';
import 'package:kairo/features/home/data/models/calendar_event.dart';

class FakeCalendarApi implements CalendarApi {
  FakeCalendarApi({this.events = const [], this.listError});

  final List<CalendarEvent> events;
  final Exception? listError;

  @override
  Future<List<CalendarEvent>> list() async {
    final error = listError;
    if (error != null) {
      throw error;
    }
    return events;
  }
}
