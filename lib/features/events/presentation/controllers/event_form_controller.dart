import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:kairo/features/events/data/events_api.dart';
import 'package:kairo/features/events/data/models/event.dart';
import 'package:kairo/features/events/data/models/event_input.dart';
import 'package:kairo/features/home/presentation/controllers/agenda_controller.dart';
import 'package:kairo/features/reminders/presentation/controllers/reminders_controller.dart';

final FutureProviderFamily<Event, String> eventByIdProvider =
    FutureProvider.family<Event, String>(
      (ref, eventId) => ref.watch(eventsApiProvider).get(eventId),
      isAutoDispose: true,
    );

class EventFormController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<bool> save({required EventInput input, String? eventId}) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      final api = ref.read(eventsApiProvider);
      if (eventId == null) {
        await api.create(input);
      } else {
        await api.update(eventId, input);
      }
      ref
        ..invalidate(agendaProvider)
        ..invalidate(upcomingEventsProvider);
      if (eventId != null) {
        ref.invalidate(eventByIdProvider(eventId));
      }
    });
    if (ref.mounted) {
      state = result;
    }
    return !result.hasError;
  }
}

final eventFormControllerProvider =
    AsyncNotifierProvider<EventFormController, void>(
      EventFormController.new,
      isAutoDispose: true,
    );
