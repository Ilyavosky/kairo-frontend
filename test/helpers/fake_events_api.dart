import 'package:kairo/features/events/data/events_api.dart';
import 'package:kairo/features/events/data/models/event.dart';
import 'package:kairo/features/events/data/models/event_input.dart';
import 'package:kairo/features/events/domain/event_type.dart';

class FakeEventsApi implements EventsApi {
  FakeEventsApi({List<Event> events = const [], this.saveError})
    : events = [...events];

  final List<Event> events;
  final Exception? saveError;
  final List<EventInput> created = [];
  final Map<String, EventInput> updated = {};

  @override
  Future<List<Event>> list({
    DateTime? from,
    DateTime? to,
    EventType? type,
  }) async => [
    for (final event in events)
      if (type == null || event.type == type) event,
  ];

  @override
  Future<Event> get(String eventId) async =>
      events.firstWhere((event) => event.id == eventId);

  @override
  Future<Event> create(EventInput input) async {
    created.add(input);
    final error = saveError;
    if (error != null) {
      throw error;
    }
    final event = _from('evento-nuevo-${created.length}', input);
    events.add(event);
    return event;
  }

  @override
  Future<Event> update(String eventId, EventInput input) async {
    updated[eventId] = input;
    final error = saveError;
    if (error != null) {
      throw error;
    }
    final event = _from(eventId, input);
    final index = events.indexWhere((item) => item.id == eventId);
    if (index >= 0) {
      events[index] = event;
    }
    return event;
  }

  Event _from(String id, EventInput input) => Event(
    id: id,
    title: input.title,
    start: input.start,
    end: input.end,
    type: input.type,
    place: input.place,
    description: input.description,
    subjectId: input.subjectId,
    activityId: input.activityId,
  );
}
