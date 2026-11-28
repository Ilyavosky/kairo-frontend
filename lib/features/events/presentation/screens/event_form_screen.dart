import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/error_view.dart';
import 'package:kairo/core/widgets/form_error_message.dart';
import 'package:kairo/core/widgets/kairo_header.dart';
import 'package:kairo/core/widgets/kairo_text_field.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/domain/due_label.dart';
import 'package:kairo/features/activities/presentation/widgets/picker_field.dart';
import 'package:kairo/features/events/data/models/event.dart';
import 'package:kairo/features/events/data/models/event_input.dart';
import 'package:kairo/features/events/domain/event_type.dart';
import 'package:kairo/features/events/domain/event_validator.dart';
import 'package:kairo/features/events/presentation/controllers/event_form_controller.dart';
import 'package:kairo/features/subjects/data/models/subject.dart';
import 'package:kairo/features/subjects/data/subjects_api.dart';
import 'package:kairo/features/time_tracking/presentation/controllers/timer_options.dart';

class EventFormScreen extends ConsumerWidget {
  const EventFormScreen({this.eventId, this.initial, super.key});

  final String? eventId;
  final Event? initial;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = eventId;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KairoHeader(
          title: id == null ? 'Nuevo evento' : 'Editar evento',
          onBack: () => context.pop(),
        ),
        Expanded(child: id == null ? const _EventForm() : _existing(ref, id)),
      ],
    );
  }

  Widget _existing(WidgetRef ref, String id) {
    final fallback = initial;
    if (fallback != null && fallback.id == id) {
      return _EventForm(event: fallback);
    }
    final event = ref.watch(eventByIdProvider(id));
    return switch (event) {
      AsyncData(:final value) => _EventForm(event: value),
      AsyncError(:final error) => ErrorView(
        message: toAppException(error).message,
        onRetry: () => ref.invalidate(eventByIdProvider(id)),
      ),
      _ => const Center(
        child: CircularProgressIndicator(semanticsLabel: 'Cargando'),
      ),
    };
  }
}

class _EventForm extends ConsumerStatefulWidget {
  const _EventForm({this.event});

  final Event? event;

  @override
  ConsumerState<_EventForm> createState() => _EventFormState();
}

class _EventFormState extends ConsumerState<_EventForm> {
  final _formKey = GlobalKey<FormState>();
  final _startFieldKey = GlobalKey<FormFieldState<String>>();
  final _endFieldKey = GlobalKey<FormFieldState<String>>();
  late final TextEditingController _titleController = TextEditingController(
    text: widget.event?.title,
  );
  late final TextEditingController _placeController = TextEditingController(
    text: widget.event?.place,
  );
  late final TextEditingController _descriptionController =
      TextEditingController(text: widget.event?.description);
  late EventType _type = widget.event?.type ?? EventType.exam;
  late DateTime? _start = widget.event?.start.toLocal();
  late DateTime? _end = widget.event?.end.toLocal();
  late String? _subjectId = widget.event?.subjectId;
  late String? _activityId = widget.event?.activityId;

  @override
  void dispose() {
    _titleController.dispose();
    _placeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _revalidateDates() {
    for (final key in [_startFieldKey, _endFieldKey]) {
      if (key.currentState?.hasError ?? false) {
        key.currentState?.validate();
      }
    }
  }

  Future<DateTime?> _pickDateTime(DateTime? current, String title) async {
    final now = DateTime.now();
    final initial = current ?? DateTime(now.year, now.month, now.day, 9);
    final first = DateTime(now.year - 1);
    final date = await showDatePicker(
      context: context,
      initialDate: initial.isBefore(first) ? first : initial,
      firstDate: first,
      lastDate: DateTime(now.year + 5),
      helpText: title,
    );
    if (date == null || !mounted) {
      return null;
    }
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
      helpText: title,
    );
    if (time == null) {
      return null;
    }
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  Future<void> _pickStart() async {
    final picked = await _pickDateTime(_start, 'Inicio del evento');
    if (picked == null || !mounted) {
      return;
    }
    setState(() {
      final previous = _start;
      final end = _end;
      if (previous != null && end != null && end.isAfter(previous)) {
        _end = picked.add(end.difference(previous));
      } else if (end == null || !end.isAfter(picked)) {
        _end = picked.add(const Duration(hours: 1));
      }
      _start = picked;
    });
    _revalidateDates();
  }

  Future<void> _pickEnd() async {
    final picked = await _pickDateTime(_end ?? _start, 'Fin del evento');
    if (picked == null || !mounted) {
      return;
    }
    setState(() => _end = picked);
    _revalidateDates();
  }

  Future<void> _pickType() async {
    final choice = await showPickerSheet<EventType>(
      context,
      selected: _type,
      options: [
        for (final type in EventType.values) PickerOption(type, type.label),
      ],
    );
    if (choice != null && mounted) {
      setState(() => _type = choice.value);
    }
  }

  Future<void> _pickSubject(List<Subject> subjects) async {
    final choice = await showPickerSheet<String?>(
      context,
      selected: _subjectId,
      options: [
        const PickerOption(null, 'Sin materia'),
        for (final subject in subjects) PickerOption(subject.id, subject.name),
      ],
    );
    if (choice != null && mounted) {
      setState(() => _subjectId = choice.value);
    }
  }

  Future<void> _pickActivity(List<Activity> activities) async {
    final choice = await showPickerSheet<String?>(
      context,
      selected: _activityId,
      options: [
        const PickerOption(null, 'Sin actividad'),
        for (final activity in activities)
          PickerOption(activity.id, activity.title),
      ],
    );
    if (choice != null && mounted) {
      setState(() => _activityId = choice.value);
    }
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    final start = _start;
    final end = _end;
    if (!(_formKey.currentState?.validate() ?? false) ||
        start == null ||
        end == null) {
      return;
    }
    final messenger = ScaffoldMessenger.of(context);
    final event = widget.event;
    final saved = await ref
        .read(eventFormControllerProvider.notifier)
        .save(
          eventId: event?.id,
          input: EventInput(
            title: _titleController.text.trim(),
            type: _type,
            start: start,
            end: end,
            place: EventValidator.clean(_placeController.text),
            description: EventValidator.clean(_descriptionController.text),
            subjectId: _subjectId,
            activityId: _activityId,
          ),
        );
    if (saved && mounted) {
      context.pop();
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              event == null ? 'Evento guardado.' : 'Cambios guardados.',
            ),
          ),
        );
    }
  }

  String? _nameOf<T>(
    List<T> items,
    String? id,
    String Function(T) idOf,
    String Function(T) nameOf,
  ) {
    for (final item in items) {
      if (idOf(item) == id) {
        return nameOf(item);
      }
    }
    return null;
  }

  String _label(DateTime value) =>
      '${DueLabel.shortDate(value)}, ${DueLabel.hour(value)}';

  @override
  Widget build(BuildContext context) {
    final subjects = ref.watch(subjectsProvider).value ?? const <Subject>[];
    final activities =
        ref.watch(openActivitiesProvider).value ?? const <Activity>[];
    final form = ref.watch(eventFormControllerProvider);
    final loading = form.isLoading;
    final error = form.hasError && !loading
        ? toAppException(form.error!).message
        : null;
    final start = _start;
    final end = _end;
    final subjectName = _subjectId == null
        ? null
        : _nameOf(subjects, _subjectId, (s) => s.id, (s) => s.name);
    final activityName = _activityId == null
        ? null
        : _nameOf(activities, _activityId, (a) => a.id, (a) => a.title) ??
              'Actividad vinculada';

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          KairoSpacing.page,
          KairoSpacing.md,
          KairoSpacing.page,
          96,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            KairoTextField(
              label: 'Nombre del evento',
              controller: _titleController,
              hint: 'Ej. Examen parcial de redes',
              validator: EventValidator.title,
              enabled: !loading,
            ),
            const SizedBox(height: KairoSpacing.xl),
            PickerField(
              label: 'Tipo',
              placeholder: 'Elige el tipo',
              icon: Icons.category_outlined,
              value: _type.label,
              onTap: _pickType,
              enabled: !loading,
            ),
            const SizedBox(height: KairoSpacing.xl),
            PickerField(
              label: 'Empieza',
              placeholder: 'Elige fecha y hora',
              icon: Icons.event_outlined,
              fieldKey: _startFieldKey,
              value: start == null ? null : _label(start),
              validator: () => EventValidator.start(_start),
              onTap: _pickStart,
              enabled: !loading,
            ),
            const SizedBox(height: KairoSpacing.xl),
            PickerField(
              label: 'Termina',
              placeholder: 'Elige fecha y hora',
              icon: Icons.event_available_outlined,
              fieldKey: _endFieldKey,
              value: end == null ? null : _label(end),
              validator: () => EventValidator.end(_start, _end),
              onTap: _pickEnd,
              enabled: !loading,
            ),
            const SizedBox(height: KairoSpacing.xl),
            KairoTextField(
              label: 'Lugar (opcional)',
              controller: _placeController,
              hint: 'Ej. Edificio B, aula 3',
              validator: EventValidator.place,
              enabled: !loading,
            ),
            const SizedBox(height: KairoSpacing.xl),
            PickerField(
              label: 'Materia (opcional)',
              placeholder: 'Sin materia',
              icon: Icons.school_outlined,
              value: subjectName,
              onTap: () => _pickSubject(subjects),
              onClear: () => setState(() => _subjectId = null),
              enabled: !loading,
            ),
            const SizedBox(height: KairoSpacing.xl),
            PickerField(
              label: 'Actividad relacionada (opcional)',
              placeholder: 'Sin actividad',
              icon: Icons.assignment_outlined,
              value: activityName,
              onTap: () => _pickActivity(activities),
              onClear: () => setState(() => _activityId = null),
              enabled: !loading,
            ),
            const SizedBox(height: KairoSpacing.xl),
            KairoTextField(
              label: 'Notas (opcional)',
              controller: _descriptionController,
              minLines: 2,
              maxLines: 5,
              validator: EventValidator.description,
              enabled: !loading,
            ),
            if (error != null) ...[
              const SizedBox(height: KairoSpacing.lg),
              FormErrorMessage(message: error),
            ],
            const SizedBox(height: KairoSpacing.xl),
            FilledButton(
              onPressed: loading ? null : _save,
              child: Text(
                loading
                    ? 'Guardando…'
                    : widget.event == null
                    ? 'Guardar evento'
                    : 'Guardar cambios',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
