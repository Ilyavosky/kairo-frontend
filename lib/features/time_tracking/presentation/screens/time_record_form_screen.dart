import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/error_view.dart';
import 'package:kairo/core/widgets/form_error_message.dart';
import 'package:kairo/core/widgets/kairo_header.dart';
import 'package:kairo/core/widgets/kairo_text_field.dart';
import 'package:kairo/features/activities/data/categories_api.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';
import 'package:kairo/features/activities/presentation/widgets/picker_field.dart';
import 'package:kairo/features/time_tracking/data/models/time_record.dart';
import 'package:kairo/features/time_tracking/data/models/time_record_input.dart';
import 'package:kairo/features/time_tracking/data/time_records_api.dart';
import 'package:kairo/features/time_tracking/domain/duration_format.dart';
import 'package:kairo/features/time_tracking/domain/time_record_validator.dart';
import 'package:kairo/features/time_tracking/presentation/controllers/time_record_form_controller.dart';
import 'package:kairo/features/time_tracking/presentation/controllers/timer_options.dart';
import 'package:kairo/features/time_tracking/presentation/widgets/date_time_picker.dart';

class TimeRecordFormScreen extends ConsumerWidget {
  const TimeRecordFormScreen({this.recordId, this.initial, super.key});

  final String? recordId;
  final TimeRecord? initial;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KairoHeader(
          title: recordId == null ? 'Nuevo registro' : 'Editar registro',
          onBack: () => context.pop(),
        ),
        Expanded(
          child: recordId == null
              ? const _TimeRecordForm()
              : _body(ref, recordId!),
        ),
      ],
    );
  }

  Widget _body(WidgetRef ref, String recordId) {
    final records = ref.watch(timeRecordsProvider);
    final list = records.value;
    TimeRecord? found;
    for (final record in list ?? const <TimeRecord>[]) {
      if (record.id == recordId) {
        found = record;
      }
    }
    found ??= initial?.id == recordId ? initial : null;
    if (found != null) {
      return _TimeRecordForm(record: found);
    }
    if (list != null) {
      return const Center(child: Text('Este registro ya no está disponible.'));
    }
    final error = records.error;
    if (error != null) {
      return ErrorView(
        message: toAppException(error).message,
        onRetry: () => ref.invalidate(timeRecordsProvider),
      );
    }
    return const Center(
      child: CircularProgressIndicator(semanticsLabel: 'Cargando'),
    );
  }
}

class _TimeRecordForm extends ConsumerStatefulWidget {
  const _TimeRecordForm({this.record});

  final TimeRecord? record;

  @override
  ConsumerState<_TimeRecordForm> createState() => _TimeRecordFormState();
}

class _TimeRecordFormState extends ConsumerState<_TimeRecordForm> {
  final _formKey = GlobalKey<FormState>();
  final _rangeFieldKey = GlobalKey<FormFieldState<String>>();
  final _categoryFieldKey = GlobalKey<FormFieldState<String>>();
  late final TextEditingController _noteController;
  String? _categoryId;
  String? _activityId;
  DateTime? _start;
  DateTime? _end;

  @override
  void initState() {
    super.initState();
    final record = widget.record;
    _noteController = TextEditingController(text: record?.note);
    _categoryId = record?.categoryId;
    _activityId = record?.activityId;
    _start = record?.start.toLocal();
    _end = record?.end.toLocal();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickCategory(List<ActivityCategory> categories) async {
    if (categories.isEmpty) {
      return;
    }
    final choice = await showPickerSheet<String?>(
      context,
      selected: _categoryId,
      options: [
        for (final category in categories)
          PickerOption(category.id, category.name),
      ],
    );
    if (choice != null && mounted) {
      setState(() => _categoryId = choice.value);
      if (_categoryFieldKey.currentState?.hasError ?? false) {
        _categoryFieldKey.currentState?.validate();
      }
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
    if (choice == null || !mounted) {
      return;
    }
    String? activityCategory;
    for (final activity in activities) {
      if (activity.id == choice.value) {
        activityCategory = activity.categoryId;
      }
    }
    setState(() {
      _activityId = choice.value;
      _categoryId ??= activityCategory;
    });
    if (activityCategory != null &&
        (_categoryFieldKey.currentState?.hasError ?? false)) {
      _categoryFieldKey.currentState?.validate();
    }
  }

  Future<void> _pickStart() async {
    final value = await pickDateTime(
      context,
      initial: _start ?? _currentMinute().subtract(const Duration(hours: 1)),
      title: 'Inicio',
    );
    if (value != null && mounted) {
      setState(() => _start = value);
      _revalidateRange();
    }
  }

  Future<void> _pickEnd() async {
    final now = _currentMinute();
    final suggested = _start?.add(const Duration(hours: 1));
    final value = await pickDateTime(
      context,
      initial:
          _end ??
          (suggested != null && suggested.isBefore(now) ? suggested : now),
      title: 'Fin',
    );
    if (value != null && mounted) {
      setState(() => _end = value);
      _revalidateRange();
    }
  }

  DateTime _currentMinute() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, now.hour, now.minute);
  }

  void _revalidateRange() {
    if (_rangeFieldKey.currentState?.hasError ?? false) {
      _rangeFieldKey.currentState?.validate();
    }
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    final categoryId = _categoryId;
    final start = _start;
    final end = _end;
    if (!(_formKey.currentState?.validate() ?? false) ||
        categoryId == null ||
        start == null ||
        end == null) {
      return;
    }
    final note = _noteController.text.trim();
    final saved = await ref
        .read(timeRecordFormControllerProvider.notifier)
        .save(
          recordId: widget.record?.id,
          input: TimeRecordInput(
            categoryId: categoryId,
            activityId: _activityId,
            start: start.toUtc(),
            end: end.toUtc(),
            note: note.isEmpty ? null : note,
          ),
        );
    if (saved && mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categories =
        ref.watch(categoriesProvider).value ?? const <ActivityCategory>[];
    final activities =
        ref.watch(openActivitiesProvider).value ?? const <Activity>[];
    final form = ref.watch(timeRecordFormControllerProvider);
    final loading = form.isLoading;
    final error = form.hasError && !loading
        ? toAppException(form.error!).message
        : null;
    String? categoryName;
    for (final category in categories) {
      if (category.id == _categoryId) {
        categoryName = category.name;
      }
    }
    String? activityTitle;
    for (final activity in activities) {
      if (activity.id == _activityId) {
        activityTitle = activity.title;
      }
    }
    final start = _start;
    final end = _end;
    final duration = start == null || end == null
        ? null
        : end.difference(start);

    return Form(
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
              duration == null ||
                      duration.isNegative ||
                      duration == Duration.zero
                  ? '—'
                  : DurationFormat.short(duration),
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: KairoSpacing.xl),
            PickerField(
              label: 'Categoría',
              placeholder: 'Selecciona una categoría',
              icon: Icons.category_outlined,
              fieldKey: _categoryFieldKey,
              value: categoryName,
              validator: () => TimeRecordValidator.category(_categoryId),
              onTap: () => _pickCategory(categories),
              enabled: !loading,
            ),
            const SizedBox(height: KairoSpacing.xl),
            PickerField(
              label: 'Actividad (opcional)',
              placeholder: 'Sin actividad',
              icon: Icons.task_alt,
              value: activityTitle,
              onTap: () => _pickActivity(activities),
              onClear: () => setState(() => _activityId = null),
              enabled: !loading,
            ),
            const SizedBox(height: KairoSpacing.xl),
            PickerField(
              label: 'Inicio',
              placeholder: 'Elige la fecha y hora',
              icon: Icons.play_circle_outline,
              value: start == null ? null : dateTimeLabel(start),
              onTap: _pickStart,
              enabled: !loading,
            ),
            const SizedBox(height: KairoSpacing.xl),
            PickerField(
              label: 'Fin',
              placeholder: 'Elige la fecha y hora',
              icon: Icons.stop_circle_outlined,
              fieldKey: _rangeFieldKey,
              value: end == null ? null : dateTimeLabel(end),
              validator: () => TimeRecordValidator.range(
                _start,
                _end,
                DateTime.now(),
                originalEnd: widget.record?.end.toLocal(),
              ),
              onTap: _pickEnd,
              enabled: !loading,
            ),
            const SizedBox(height: KairoSpacing.xl),
            KairoTextField(
              label: 'Nota (opcional)',
              controller: _noteController,
              hint: 'Qué hiciste en este tiempo',
              keyboardType: TextInputType.multiline,
              minLines: 2,
              maxLines: 4,
              validator: TimeRecordValidator.note,
              enabled: !loading,
            ),
            if (error != null) ...[
              const SizedBox(height: KairoSpacing.lg),
              FormErrorMessage(message: error),
            ],
            const SizedBox(height: KairoSpacing.xl),
            FilledButton(
              onPressed: loading ? null : _save,
              child: loading
                  ? SizedBox.square(
                      dimension: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: theme.colorScheme.onPrimary,
                        semanticsLabel: 'Guardando',
                      ),
                    )
                  : Text(
                      widget.record == null
                          ? 'Guardar registro'
                          : 'Guardar cambios',
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
