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
import 'package:kairo/features/activities/data/models/activity_input.dart';
import 'package:kairo/features/activities/domain/activity_modality.dart';
import 'package:kairo/features/activities/domain/activity_status.dart';
import 'package:kairo/features/activities/domain/activity_validator.dart';
import 'package:kairo/features/activities/domain/due_label.dart';
import 'package:kairo/features/activities/presentation/controllers/activities_controller.dart';
import 'package:kairo/features/activities/presentation/controllers/activity_form_controller.dart';
import 'package:kairo/features/activities/presentation/widgets/picker_field.dart';
import 'package:kairo/features/subjects/data/models/subject.dart';
import 'package:kairo/features/subjects/data/subjects_api.dart';
import 'package:kairo/features/tags/presentation/widgets/activity_tags_section.dart';

class ActivityFormScreen extends ConsumerWidget {
  const ActivityFormScreen({
    this.activityId,
    this.initial,
    this.draftText,
    super.key,
  });

  final String? activityId;
  final Activity? initial;
  final String? draftText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = activityId;
    final title = id == null ? 'Nueva actividad' : 'Editar actividad';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KairoHeader(title: title, onBack: () => context.pop()),
        Expanded(
          child: id == null
              ? _ActivityForm(draftText: draftText)
              : _existing(ref, id),
        ),
      ],
    );
  }

  Widget _existing(WidgetRef ref, String id) {
    final activities = ref.watch(activitiesControllerProvider);
    final list = activities.value;
    Activity? found;
    for (final activity in list ?? const <Activity>[]) {
      if (activity.id == id) {
        found = activity;
      }
    }
    found ??= initial?.id == id ? initial : null;
    if (found != null) {
      return _ActivityForm(activity: found);
    }
    if (list != null) {
      return const Center(child: Text('Esta actividad ya no está disponible.'));
    }
    final error = activities.error;
    if (error != null) {
      return ErrorView(
        message: toAppException(error).message,
        onRetry: () => ref.invalidate(activitiesControllerProvider),
      );
    }
    return const Center(
      child: CircularProgressIndicator(semanticsLabel: 'Cargando'),
    );
  }
}

class _ActivityForm extends ConsumerStatefulWidget {
  const _ActivityForm({this.activity, this.draftText});

  final Activity? activity;
  final String? draftText;

  @override
  ConsumerState<_ActivityForm> createState() => _ActivityFormState();
}

class _ActivityFormState extends ConsumerState<_ActivityForm> {
  final _formKey = GlobalKey<FormState>();
  final _categoryFieldKey = GlobalKey<FormFieldState<String>>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  String? _subjectId;
  String? _categoryId;
  DateTime? _dueAt;
  late int _priority;
  late ActivityModality _modality;

  @override
  void initState() {
    super.initState();
    final activity = widget.activity;
    final draft = activity == null ? widget.draftText?.trim() : null;
    _titleController = TextEditingController(
      text: activity?.title ?? _titleFromDraft(draft),
    );
    _descriptionController = TextEditingController(
      text: activity?.description ?? draft,
    );
    _subjectId = activity?.subjectId;
    _categoryId = activity?.categoryId;
    _dueAt = activity?.dueAt?.toLocal();
    _priority = activity?.priority ?? 3;
    _modality = activity?.modality ?? ActivityModality.inPerson;
  }

  String? _titleFromDraft(String? draft) {
    if (draft == null || draft.isEmpty) {
      return null;
    }
    final line = draft.split('\n').first.trim();
    return line.length > ActivityValidator.titleMaxLength
        ? line.substring(0, ActivityValidator.titleMaxLength)
        : line;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
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

  Future<void> _pickCategory() async {
    final categories = ref.read(categoriesProvider);
    final list = categories.value;
    if (list == null) {
      if (categories.hasError) {
        ref.invalidate(categoriesProvider);
        _showMessage('No se pudieron cargar las categorías.');
      } else {
        _showMessage('Cargando categorías…');
      }
      return;
    }
    if (list.isEmpty) {
      _showMessage('Aún no hay categorías disponibles.');
      return;
    }
    final choice = await showPickerSheet<String?>(
      context,
      selected: _categoryId,
      options: [
        for (final category in list) PickerOption(category.id, category.name),
      ],
    );
    if (choice != null && mounted) {
      setState(() => _categoryId = choice.value);
      if (_categoryFieldKey.currentState?.hasError ?? false) {
        _categoryFieldKey.currentState?.validate();
      }
    }
  }

  Future<void> _pickDue() async {
    final now = DateTime.now();
    final current = _dueAt ?? DateTime(now.year, now.month, now.day, 23, 59);
    final first = DateTime(now.year - 1);
    final date = await showDatePicker(
      context: context,
      initialDate: current.isBefore(first) ? first : current,
      firstDate: first,
      lastDate: DateTime(now.year + 5),
      helpText: 'Fecha de entrega',
    );
    if (date == null || !mounted) {
      return;
    }
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(current),
      helpText: 'Hora de entrega',
    );
    if (time == null || !mounted) {
      return;
    }
    setState(
      () => _dueAt = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      ),
    );
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    final categoryId = _categoryId;
    if (!(_formKey.currentState?.validate() ?? false) || categoryId == null) {
      return;
    }
    final saved = await ref
        .read(activityFormControllerProvider.notifier)
        .save(
          activityId: widget.activity?.id,
          input: ActivityInput(
            title: _titleController.text.trim(),
            description: ActivityValidator.clean(_descriptionController.text),
            dueAt: _dueAt?.toUtc(),
            priority: _priority,
            modality: _modality,
            subjectId: _subjectId,
            categoryId: categoryId,
          ),
        );
    if (saved && mounted) {
      context.pop(true);
    }
  }

  Future<void> _toggleStatus(Activity activity) async {
    final done = await ref
        .read(activityFormControllerProvider.notifier)
        .setCompleted(
          activity.id,
          completed: activity.status != ActivityStatus.completed,
        );
    if (done && mounted) {
      context.pop();
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activity = widget.activity;
    final subjects = ref.watch(subjectsProvider).value ?? const <Subject>[];
    final categories =
        ref.watch(categoriesProvider).value ?? const <ActivityCategory>[];
    final form = ref.watch(activityFormControllerProvider);
    final loading = form.isLoading;
    final error = form.hasError && !loading
        ? toAppException(form.error!).message
        : null;
    final due = _dueAt;
    final subjectId = _subjectId;

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
            KairoTextField(
              label: 'Título',
              controller: _titleController,
              hint: 'Ej. Reporte de práctica 3',
              icon: Icons.edit_note,
              textInputAction: TextInputAction.next,
              validator: ActivityValidator.title,
              enabled: !loading,
            ),
            const SizedBox(height: KairoSpacing.xl),
            KairoTextField(
              label: 'Descripción (opcional)',
              controller: _descriptionController,
              hint: 'Detalles, instrucciones o enlaces',
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: 5,
              validator: ActivityValidator.description,
              enabled: !loading,
            ),
            const SizedBox(height: KairoSpacing.xl),
            PickerField(
              label: 'Materia',
              placeholder: 'Sin materia',
              icon: Icons.menu_book,
              value: subjectId == null
                  ? null
                  : _nameOf<Subject>(
                      subjects,
                      subjectId,
                      (subject) => subject.id,
                      (subject) => subject.name,
                    ),
              onTap: () => _pickSubject(subjects),
              onClear: () => setState(() => _subjectId = null),
              enabled: !loading,
            ),
            const SizedBox(height: KairoSpacing.xl),
            PickerField(
              label: 'Categoría',
              placeholder: 'Selecciona una categoría',
              icon: Icons.category_outlined,
              fieldKey: _categoryFieldKey,
              value: _nameOf<ActivityCategory>(
                categories,
                _categoryId,
                (category) => category.id,
                (category) => category.name,
              ),
              validator: () => ActivityValidator.category(_categoryId),
              onTap: _pickCategory,
              enabled: !loading,
            ),
            const SizedBox(height: KairoSpacing.xl),
            PickerField(
              label: 'Fecha de entrega (opcional)',
              placeholder: 'Sin fecha de entrega',
              icon: Icons.event,
              value: due == null
                  ? null
                  : '${DueLabel.shortDate(due)} ${due.year}, '
                        '${DueLabel.hour(due)}',
              onTap: _pickDue,
              onClear: () => setState(() => _dueAt = null),
              enabled: !loading,
            ),
            const SizedBox(height: KairoSpacing.xl),
            Text(
              'Prioridad',
              style: theme.textTheme.titleSmall?.copyWith(fontSize: 16),
            ),
            const SizedBox(height: KairoSpacing.sm),
            SegmentedButton<int>(
              showSelectedIcon: false,
              segments: [
                for (final level in ActivityValidator.priorityLabels.keys)
                  ButtonSegment(value: level, label: Text('$level')),
              ],
              selected: {_priority},
              onSelectionChanged: loading
                  ? null
                  : (selection) => setState(() => _priority = selection.first),
            ),
            const SizedBox(height: KairoSpacing.xs),
            Text(
              ActivityValidator.priorityLabels[_priority] ?? '',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: KairoSpacing.xl),
            Text(
              'Modalidad',
              style: theme.textTheme.titleSmall?.copyWith(fontSize: 16),
            ),
            const SizedBox(height: KairoSpacing.sm),
            SegmentedButton<ActivityModality>(
              showSelectedIcon: false,
              segments: [
                for (final modality in ActivityModality.values)
                  ButtonSegment(value: modality, label: Text(modality.label)),
              ],
              selected: {_modality},
              onSelectionChanged: loading
                  ? null
                  : (selection) => setState(() => _modality = selection.first),
            ),
            if (activity != null) ...[
              const SizedBox(height: KairoSpacing.xl),
              ActivityTagsSection(activityId: activity.id),
            ],
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
                      activity == null
                          ? 'Guardar actividad'
                          : 'Guardar cambios',
                    ),
            ),
            if (activity != null) ...[
              const SizedBox(height: KairoSpacing.md),
              OutlinedButton.icon(
                onPressed: loading ? null : () => _toggleStatus(activity),
                icon: Icon(
                  activity.status == ActivityStatus.completed
                      ? Icons.replay
                      : Icons.check_circle_outline,
                ),
                label: Text(
                  activity.status == ActivityStatus.completed
                      ? 'Marcar como pendiente'
                      : 'Marcar como completada',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
