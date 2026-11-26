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
import 'package:kairo/features/activities/data/models/activity_category.dart';
import 'package:kairo/features/activities/presentation/widgets/picker_field.dart';
import 'package:kairo/features/goals/data/models/goal.dart';
import 'package:kairo/features/goals/data/models/goal_input.dart';
import 'package:kairo/features/goals/domain/goal_format.dart';
import 'package:kairo/features/goals/domain/goal_period.dart';
import 'package:kairo/features/goals/domain/goal_type.dart';
import 'package:kairo/features/goals/domain/goal_validator.dart';
import 'package:kairo/features/goals/presentation/controllers/goal_form_controller.dart';
import 'package:kairo/features/goals/presentation/controllers/goals_controller.dart';

class GoalFormScreen extends ConsumerWidget {
  const GoalFormScreen({this.goalId, this.initial, super.key});

  final String? goalId;
  final Goal? initial;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = goalId;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KairoHeader(
          title: id == null ? 'Nueva meta' : 'Cambiar objetivo',
          onBack: () => context.pop(),
        ),
        Expanded(child: id == null ? const _GoalForm() : _existing(ref, id)),
      ],
    );
  }

  Widget _existing(WidgetRef ref, String id) {
    final goals = ref.watch(activeGoalsProvider);
    final list = goals.value;
    Goal? found;
    for (final item in list ?? const <GoalWithProgress>[]) {
      if (item.goal.id == id) {
        found = item.goal;
      }
    }
    found ??= initial?.id == id ? initial : null;
    if (found != null) {
      return _GoalForm(goal: found);
    }
    if (list != null) {
      return const Center(child: Text('Esta meta ya no está activa.'));
    }
    final error = goals.error;
    if (error != null) {
      return ErrorView(
        message: toAppException(error).message,
        onRetry: () => ref.invalidate(activeGoalsProvider),
      );
    }
    return const Center(
      child: CircularProgressIndicator(semanticsLabel: 'Cargando'),
    );
  }
}

class _GoalForm extends ConsumerStatefulWidget {
  const _GoalForm({this.goal});

  final Goal? goal;

  @override
  ConsumerState<_GoalForm> createState() => _GoalFormState();
}

class _GoalFormState extends ConsumerState<_GoalForm> {
  final _formKey = GlobalKey<FormState>();
  final _categoryFieldKey = GlobalKey<FormFieldState<String>>();
  final _targetFieldKey = GlobalKey<FormFieldState<String>>();
  final _hoursController = TextEditingController();
  final _minutesController = TextEditingController();
  final _eventsController = TextEditingController();
  String? _categoryId;
  GoalType _type = GoalType.time;
  GoalPeriod _period = GoalPeriod.week;

  bool get _editing => widget.goal != null;

  @override
  void initState() {
    super.initState();
    final goal = widget.goal;
    if (goal != null) {
      _categoryId = goal.categoryId;
      _type = goal.type;
      _period = goal.period;
      if (goal.type == GoalType.time) {
        _hoursController.text = '${goal.target ~/ 60}';
        _minutesController.text = '${goal.target % 60}';
      } else {
        _eventsController.text = '${goal.target}';
      }
    }
    for (final controller in [
      _hoursController,
      _minutesController,
      _eventsController,
    ]) {
      controller.addListener(_refreshTarget);
    }
  }

  @override
  void dispose() {
    _hoursController.dispose();
    _minutesController.dispose();
    _eventsController.dispose();
    super.dispose();
  }

  int? get _target => switch (_type) {
    GoalType.time => GoalValidator.timeTarget(
      _hoursController.text,
      _minutesController.text,
    ),
    GoalType.events => GoalValidator.wholeNumber(_eventsController.text),
  };

  void _refreshTarget() {
    setState(() {});
    if (_targetFieldKey.currentState?.hasError ?? false) {
      _targetFieldKey.currentState?.validate();
    }
  }

  Future<void> _pickCategory(List<ActivityCategory> categories) async {
    if (categories.isEmpty) {
      ref.invalidate(categoriesProvider);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Aún no hay categorías disponibles.')),
        );
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

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    final categoryId = _categoryId;
    final target = _target;
    if (!(_formKey.currentState?.validate() ?? false) ||
        categoryId == null ||
        target == null) {
      return;
    }
    final controller = ref.read(goalFormControllerProvider.notifier);
    final goal = widget.goal;
    final saved = goal == null
        ? await controller.create(
            GoalInput(
              categoryId: categoryId,
              type: _type,
              period: _period,
              target: target,
            ),
          )
        : await controller.updateTarget(goal.id, target);
    if (saved && mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categories =
        ref.watch(categoriesProvider).value ?? const <ActivityCategory>[];
    final form = ref.watch(goalFormControllerProvider);
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
    final target = _target;
    final every = switch (_period) {
      GoalPeriod.day => 'cada día',
      GoalPeriod.week => 'cada semana',
      GoalPeriod.month => 'cada mes',
    };
    final summary = target == null || target < 1
        ? null
        : '${GoalFormat.amount(_type, target)} $every';

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
            if (_editing) ...[
              Text(
                'Solo se puede cambiar el objetivo. Para cambiar la '
                'categoría, el tipo o el periodo, desactiva esta meta y '
                'crea otra.',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: KairoSpacing.lg),
            ],
            PickerField(
              label: 'Categoría',
              placeholder: 'Selecciona una categoría',
              icon: Icons.category_outlined,
              fieldKey: _categoryFieldKey,
              value: categoryName,
              validator: () => GoalValidator.category(_categoryId),
              onTap: () => _pickCategory(categories),
              enabled: !loading && !_editing,
            ),
            const SizedBox(height: KairoSpacing.xl),
            Text(
              'Qué vas a medir',
              style: theme.textTheme.titleSmall?.copyWith(fontSize: 16),
            ),
            const SizedBox(height: KairoSpacing.sm),
            SegmentedButton<GoalType>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(
                  value: GoalType.time,
                  label: Text('Tiempo'),
                  icon: Icon(Icons.timer_outlined),
                ),
                ButtonSegment(
                  value: GoalType.events,
                  label: Text('Registros'),
                  icon: Icon(Icons.repeat),
                ),
              ],
              selected: {_type},
              onSelectionChanged: loading || _editing
                  ? null
                  : (selection) {
                      _type = selection.first;
                      _refreshTarget();
                    },
            ),
            const SizedBox(height: KairoSpacing.xs),
            Text(
              _type == GoalType.time
                  ? 'Suma el tiempo que registres en esta categoría.'
                  : 'Cuenta cuántas veces registras tiempo en esta categoría.',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: KairoSpacing.xl),
            Text(
              'Cada cuándo',
              style: theme.textTheme.titleSmall?.copyWith(fontSize: 16),
            ),
            const SizedBox(height: KairoSpacing.sm),
            SegmentedButton<GoalPeriod>(
              showSelectedIcon: false,
              segments: [
                for (final period in GoalPeriod.values)
                  ButtonSegment(value: period, label: Text(period.label)),
              ],
              selected: {_period},
              onSelectionChanged: loading || _editing
                  ? null
                  : (selection) => setState(() => _period = selection.first),
            ),
            const SizedBox(height: KairoSpacing.xl),
            if (_type == GoalType.time)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: KairoTextField(
                      label: 'Horas',
                      controller: _hoursController,
                      hint: '0',
                      keyboardType: TextInputType.number,
                      validator: GoalValidator.numberField,
                      enabled: !loading,
                    ),
                  ),
                  const SizedBox(width: KairoSpacing.md),
                  Expanded(
                    child: KairoTextField(
                      label: 'Minutos',
                      controller: _minutesController,
                      hint: '0',
                      keyboardType: TextInputType.number,
                      validator: GoalValidator.minutesField,
                      enabled: !loading,
                    ),
                  ),
                ],
              )
            else
              KairoTextField(
                label: 'Número de registros',
                controller: _eventsController,
                hint: 'Ej. 3',
                keyboardType: TextInputType.number,
                validator: GoalValidator.numberField,
                enabled: !loading,
              ),
            FormField<String>(
              key: _targetFieldKey,
              validator: (_) => GoalValidator.target(_target),
              builder: (field) {
                final message = field.errorText;
                return message == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(top: KairoSpacing.sm),
                        child: Text(
                          message,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                      );
              },
            ),
            if (summary != null) ...[
              const SizedBox(height: KairoSpacing.md),
              Text(
                'Tu meta: $summary',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
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
                  : Text(_editing ? 'Guardar cambios' : 'Guardar meta'),
            ),
          ],
        ),
      ),
    );
  }
}
