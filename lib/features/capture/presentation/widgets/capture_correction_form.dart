import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/kairo_text_field.dart';
import 'package:kairo/features/activities/data/categories_api.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';
import 'package:kairo/features/activities/domain/activity_validator.dart';
import 'package:kairo/features/activities/presentation/widgets/picker_field.dart';
import 'package:kairo/features/capture/data/models/capture.dart';
import 'package:kairo/features/capture/domain/capture_correction.dart';
import 'package:kairo/features/capture/domain/capture_fields.dart';
import 'package:kairo/features/capture/domain/capture_kind.dart';
import 'package:kairo/features/capture/presentation/controllers/capture_lookups.dart';
import 'package:kairo/features/goals/domain/goal_type.dart';
import 'package:kairo/features/subjects/data/models/subject.dart';
import 'package:kairo/features/subjects/data/subjects_api.dart';
import 'package:kairo/features/time_tracking/presentation/controllers/timer_options.dart';

class CaptureCorrectionForm extends ConsumerStatefulWidget {
  const CaptureCorrectionForm({
    required this.capture,
    required this.busy,
    required this.onSave,
    required this.onCancel,
    super.key,
  });

  final Capture capture;
  final bool busy;
  final ValueChanged<Map<String, dynamic>> onSave;
  final VoidCallback onCancel;

  @override
  ConsumerState<CaptureCorrectionForm> createState() =>
      _CaptureCorrectionFormState();
}

class _CaptureCorrectionFormState extends ConsumerState<CaptureCorrectionForm> {
  static const _textKeys = {'titulo', 'descripcion', 'nota', 'objetivo'};

  final _formKey = GlobalKey<FormState>();
  late final Map<String, Object?> _values = {...widget.capture.fields};
  late final Map<String, TextEditingController> _texts = {
    for (final key in _keys)
      if (_textKeys.contains(key))
        key: TextEditingController(text: _initialText(_values[key])),
  };

  List<String> get _keys => CaptureFields.editableKeysOf(widget.capture.kind);

  @override
  void dispose() {
    for (final controller in _texts.values) {
      controller.dispose();
    }
    super.dispose();
  }

  String _initialText(Object? value) {
    if (value == null) {
      return '';
    }
    if (value is num && value == value.roundToDouble()) {
      return '${value.round()}';
    }
    return '$value';
  }

  Object? _valueOf(String key) {
    final controller = _texts[key];
    if (controller == null) {
      return _values[key];
    }
    final text = controller.text.trim();
    if (text.isEmpty) {
      return null;
    }
    return key == 'objetivo' ? int.tryParse(text) : text;
  }

  void _save() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final edited = {for (final key in _keys) key: _valueOf(key)};
    widget.onSave(CaptureCorrection.changes(widget.capture.fields, edited));
  }

  List<PickerOption<Object?>> _optionsOf(String key) {
    switch (key) {
      case 'categoria_id':
        final categories =
            ref.read(categoriesProvider).value ?? const <ActivityCategory>[];
        return [
          for (final category in categories)
            PickerOption(category.id, category.name),
        ];
      case 'materia_id':
        final subjects = ref.read(subjectsProvider).value ?? const <Subject>[];
        return [
          const PickerOption(null, 'Sin materia'),
          for (final subject in subjects)
            PickerOption(subject.id, subject.name),
        ];
      case 'actividad_id':
        final activities =
            ref.read(openActivitiesProvider).value ?? const <Activity>[];
        return [
          const PickerOption(null, 'Sin actividad'),
          for (final activity in activities)
            PickerOption(activity.id, activity.title),
        ];
      case 'prioridad':
        return [
          for (final entry in ActivityValidator.priorityLabels.entries)
            PickerOption(entry.key, '${entry.key} · ${entry.value}'),
        ];
      case 'modalidad':
        return [
          for (final entry in CaptureFields.modalities.entries)
            PickerOption(entry.key, entry.value.label),
        ];
      case 'tipo':
        return [
          for (final entry in CaptureFields.goalTypes.entries)
            PickerOption(entry.key, entry.value.label),
        ];
      case 'periodo':
        return [
          for (final entry in CaptureFields.goalPeriods.entries)
            PickerOption(entry.key, entry.value.label),
        ];
    }
    return const [];
  }

  Future<void> _pickOption(String key) async {
    final options = _optionsOf(key);
    if (options.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('No hay opciones para elegir.')),
        );
      return;
    }
    final choice = await showPickerSheet<Object?>(
      context,
      options: options,
      selected: _values[key],
    );
    if (choice != null && mounted) {
      setState(() => _values[key] = choice.value);
    }
  }

  Future<void> _pickDate(String key) async {
    final now = DateTime.now();
    final current = DateTime.tryParse('${_values[key]}')?.toLocal() ?? now;
    final first = DateTime(now.year - 1);
    final label = CaptureFields.label(key);
    final date = await showDatePicker(
      context: context,
      initialDate: current.isBefore(first) ? first : current,
      firstDate: first,
      lastDate: DateTime(now.year + 5),
      helpText: label,
    );
    if (date == null || !mounted) {
      return;
    }
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(current),
      helpText: label,
    );
    if (time == null || !mounted) {
      return;
    }
    final picked = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() => _values[key] = picked.toUtc().toIso8601String());
  }

  String? _targetError(String? value) {
    final target = int.tryParse(value?.trim() ?? '');
    if (target == null || target < 1) {
      return 'Escribe un número entero mayor a 0';
    }
    return null;
  }

  IconData _iconOf(String key) => switch (key) {
    'categoria_id' => Icons.label_outline,
    'materia_id' => Icons.school_outlined,
    'actividad_id' => Icons.assignment_outlined,
    'prioridad' => Icons.low_priority,
    'modalidad' => Icons.place_outlined,
    'tipo' => Icons.straighten,
    'periodo' => Icons.repeat,
    _ => Icons.event_outlined,
  };

  Widget _field(String key, CaptureLookups lookups) {
    final label = CaptureFields.label(key);
    final controller = _texts[key];
    if (controller != null) {
      return switch (key) {
        'titulo' => KairoTextField(
          label: label,
          controller: controller,
          enabled: !widget.busy,
          validator: widget.capture.kind == CaptureKind.activity
              ? ActivityValidator.title
              : null,
        ),
        'objetivo' => KairoTextField(
          label: CaptureFields.goalTypes[_values['tipo']] == GoalType.events
              ? 'Objetivo (registros)'
              : 'Objetivo (minutos)',
          controller: controller,
          enabled: !widget.busy,
          keyboardType: TextInputType.number,
          validator: _targetError,
        ),
        _ => KairoTextField(
          label: label,
          controller: controller,
          enabled: !widget.busy,
          minLines: 2,
          maxLines: 4,
        ),
      };
    }
    final preview = widget.capture.copyWith(fields: {..._values});
    final isDate = CaptureFields.isDate(key);
    return PickerField(
      label: label,
      placeholder: 'Elegir',
      icon: _iconOf(key),
      value: CaptureFields.display(preview, key, lookups),
      enabled: !widget.busy,
      onTap: () => isDate ? _pickDate(key) : _pickOption(key),
      onClear: isDate ? () => setState(() => _values[key] = null) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lookups = ref.watch(captureLookupsProvider);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(KairoSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Corregir ${widget.capture.kind.label.toLowerCase()}',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: KairoSpacing.xs),
                  Text(
                    'Cambia solo lo que Kairo entendió mal. Lo demás se '
                    'guarda como está.',
                    style: theme.textTheme.bodySmall,
                  ),
                  for (final key in _keys) ...[
                    const SizedBox(height: KairoSpacing.lg),
                    _field(key, lookups),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: KairoSpacing.lg),
          FilledButton(
            onPressed: widget.busy ? null : _save,
            child: Text(widget.busy ? 'Guardando…' : 'Guardar corrección'),
          ),
          const SizedBox(height: KairoSpacing.sm),
          OutlinedButton(
            onPressed: widget.busy ? null : widget.onCancel,
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }
}
