import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/form_error_message.dart';
import 'package:kairo/core/widgets/kairo_header.dart';
import 'package:kairo/features/activities/domain/due_label.dart';
import 'package:kairo/features/activities/presentation/widgets/picker_field.dart';
import 'package:kairo/features/reminders/data/models/reminder_input.dart';
import 'package:kairo/features/reminders/domain/reminder_option.dart';
import 'package:kairo/features/reminders/domain/reminder_target.dart';
import 'package:kairo/features/reminders/domain/reminder_validator.dart';
import 'package:kairo/features/reminders/presentation/controllers/reminder_form_controller.dart';
import 'package:kairo/features/reminders/presentation/controllers/reminders_controller.dart';

class ReminderFormScreen extends ConsumerStatefulWidget {
  const ReminderFormScreen({super.key});

  @override
  ConsumerState<ReminderFormScreen> createState() => _ReminderFormScreenState();
}

class _ReminderFormScreenState extends ConsumerState<ReminderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _targetFieldKey = GlobalKey<FormFieldState<String>>();
  final _momentFieldKey = GlobalKey<FormFieldState<String>>();
  ReminderTarget _target = ReminderTarget.activity;
  String? _targetId;
  DateTime? _moment;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  String _placeholder(ReminderTarget target) => switch (target) {
    ReminderTarget.activity => 'Selecciona una actividad',
    ReminderTarget.event => 'Selecciona un evento',
    ReminderTarget.goal => 'Selecciona una meta',
  };

  String _emptyMessage(ReminderTarget target) => switch (target) {
    ReminderTarget.activity => 'No tienes actividades pendientes.',
    ReminderTarget.event => 'No tienes eventos próximos.',
    ReminderTarget.goal => 'No tienes metas activas.',
  };

  Future<void> _pickTarget(List<ReminderOption> options) async {
    if (options.isEmpty) {
      _showMessage(_emptyMessage(_target));
      return;
    }
    final choice = await showPickerSheet<String?>(
      context,
      selected: _targetId,
      options: [
        for (final option in options) PickerOption(option.id, option.fullLabel),
      ],
    );
    if (choice != null && mounted) {
      setState(() => _targetId = choice.value);
      if (_targetFieldKey.currentState?.hasError ?? false) {
        _targetFieldKey.currentState?.validate();
      }
    }
  }

  Future<void> _pickMoment() async {
    final now = DateTime.now();
    final current = _moment ?? now.add(const Duration(hours: 1));
    final date = await showDatePicker(
      context: context,
      initialDate: current.isBefore(now) ? now : current,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 2),
      helpText: 'Día del aviso',
    );
    if (date == null || !mounted) {
      return;
    }
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(current),
      helpText: 'Hora del aviso',
    );
    if (time == null || !mounted) {
      return;
    }
    setState(
      () => _moment = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      ),
    );
    if (_momentFieldKey.currentState?.hasError ?? false) {
      _momentFieldKey.currentState?.validate();
    }
  }

  Future<void> _save() async {
    final targetId = _targetId;
    final moment = _moment;
    if (!(_formKey.currentState?.validate() ?? false) ||
        targetId == null ||
        moment == null) {
      return;
    }
    final messenger = ScaffoldMessenger.of(context);
    final saved = await ref
        .read(reminderFormControllerProvider.notifier)
        .create(
          ReminderInput(
            moment: moment,
            activityId: _target == ReminderTarget.activity ? targetId : null,
            eventId: _target == ReminderTarget.event ? targetId : null,
            goalId: _target == ReminderTarget.goal ? targetId : null,
          ),
        );
    if (saved && mounted) {
      context.pop();
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('Recordatorio guardado.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final options =
        ref.watch(reminderOptionsProvider)[_target] ?? const <ReminderOption>[];
    final form = ref.watch(reminderFormControllerProvider);
    final loading = form.isLoading;
    final error = form.hasError && !loading
        ? toAppException(form.error!).message
        : null;
    String? targetName;
    for (final option in options) {
      if (option.id == _targetId) {
        targetName = option.fullLabel;
      }
    }
    final moment = _moment;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KairoHeader(title: 'Nuevo recordatorio', onBack: () => context.pop()),
        Expanded(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                KairoSpacing.page,
                KairoSpacing.md,
                KairoSpacing.page,
                KairoSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Kairo te enviará el aviso como mensaje del bot en '
                    'Telegram a la hora que elijas.',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: KairoSpacing.xl),
                  Text(
                    'Sobre qué es',
                    style: theme.textTheme.titleSmall?.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: KairoSpacing.sm),
                  SegmentedButton<ReminderTarget>(
                    showSelectedIcon: false,
                    segments: [
                      for (final target in ReminderTarget.values)
                        ButtonSegment(value: target, label: Text(target.label)),
                    ],
                    selected: {_target},
                    onSelectionChanged: loading
                        ? null
                        : (selection) => setState(() {
                            _target = selection.first;
                            _targetId = null;
                          }),
                  ),
                  const SizedBox(height: KairoSpacing.xl),
                  PickerField(
                    label: _target.label,
                    placeholder: _placeholder(_target),
                    icon: Icons.checklist,
                    fieldKey: _targetFieldKey,
                    value: targetName,
                    validator: () => ReminderValidator.target(_targetId),
                    onTap: () => _pickTarget(options),
                    enabled: !loading,
                  ),
                  const SizedBox(height: KairoSpacing.xl),
                  PickerField(
                    label: 'Cuándo avisarte',
                    placeholder: 'Elige la fecha y hora',
                    icon: Icons.notifications_active_outlined,
                    fieldKey: _momentFieldKey,
                    value: moment == null
                        ? null
                        : '${DueLabel.shortDate(moment)}, '
                              '${DueLabel.hour(moment)}',
                    validator: () =>
                        ReminderValidator.moment(_moment, DateTime.now()),
                    onTap: _pickMoment,
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
                      loading ? 'Guardando…' : 'Guardar recordatorio',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
