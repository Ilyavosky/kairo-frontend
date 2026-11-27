import 'package:kairo/features/events/data/events_api.dart';
import 'package:kairo/features/events/data/models/event.dart';

class FakeEventsApi implements EventsApi {
  FakeEventsApi({this.events = const []});

  final List<Event> events;

  @override
  Future<List<Event>> list({DateTime? from}) async => [...events];
}
