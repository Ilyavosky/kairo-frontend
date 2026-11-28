import 'package:kairo/features/events/data/events_api.dart';
import 'package:kairo/features/events/data/models/event.dart';
import 'package:kairo/features/events/domain/event_type.dart';

class FakeEventsApi implements EventsApi {
  FakeEventsApi({this.events = const []});

  final List<Event> events;

  @override
  Future<List<Event>> list({
    DateTime? from,
    DateTime? to,
    EventType? type,
  }) async => [
    for (final event in events)
      if (type == null || event.type == type) event,
  ];
}
