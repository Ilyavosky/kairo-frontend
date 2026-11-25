import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/error_view.dart';
import 'package:kairo/core/widgets/kairo_text_field.dart';
import 'package:kairo/features/activities/data/categories_api.dart';
import 'package:kairo/features/activities/data/models/activity.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';
import 'package:kairo/features/activities/domain/due_label.dart';
import 'package:kairo/features/activities/presentation/widgets/picker_field.dart';
import 'package:kairo/features/time_tracking/domain/duration_format.dart';
import 'package:kairo/features/time_tracking/domain/running_timer.dart';
import 'package:kairo/features/time_tracking/presentation/controllers/timer_controller.dart';
import 'package:kairo/features/time_tracking/presentation/controllers/timer_options.dart';
import 'package:kairo/features/time_tracking/presentation/widgets/elapsed_clock.dart';

class TimerPanel extends ConsumerWidget {
  const TimerPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(timerControllerProvider);

    return switch (timer) {
      AsyncData(:final value) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          KairoSpacing.page,
          KairoSpacing.md,
          KairoSpacing.page,
          KairoSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (value.offline) ...[
              _OfflineBanner(
                onRetry: () =>
                    ref.read(timerControllerProvider.notifier).refresh(),
              ),
              const SizedBox(height: KairoSpacing.lg),
            ],
            if (value.running case final running?)
              _RunningTimer(key: ValueKey(running.session.id), running: running)
            else
              const _IdleTimer(),
          ],
        ),
      ),
      AsyncError(:final error) => ErrorView(
        message: toAppException(error).message,
        onRetry: () => ref.invalidate(timerControllerProvider),
      ),
      _ => const Center(
        child: CircularProgressIndicator(semanticsLabel: 'Cargando'),
      ),
    };
  }
}

class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.errorContainer,
        borderRadius: BorderRadius.circular(KairoSpacing.radiusMd),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          KairoSpacing.md,
          KairoSpacing.sm,
          KairoSpacing.sm,
          KairoSpacing.sm,
        ),
        child: Row(
          children: [
            Icon(Icons.cloud_off, color: scheme.onErrorContainer),
            const SizedBox(width: KairoSpacing.md),
            Expanded(
              child: Text(
                'Sin conexión. El temporizador sigue corriendo '
                'en el servidor.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.onErrorContainer,
                ),
              ),
            ),
            TextButton(onPressed: onRetry, child: const Text('Reintentar')),
          ],
        ),
      ),
    );
  }
}

String? _categoryName(List<ActivityCategory> categories, String? id) {
  for (final category in categories) {
    if (category.id == id) {
      return category.name;
    }
  }
  return null;
}

Activity? _activityById(List<Activity> activities, String? id) {
  for (final activity in activities) {
    if (activity.id == id) {
      return activity;
    }
  }
  return null;
}

class _IdleTimer extends ConsumerStatefulWidget {
  const _IdleTimer();

  @override
  ConsumerState<_IdleTimer> createState() => _IdleTimerState();
}

class _IdleTimerState extends ConsumerState<_IdleTimer> {
  final _categoryFieldKey = GlobalKey<FormFieldState<String>>();
  String? _categoryId;
  String? _activityId;
  bool _starting = false;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _pickCategory(List<ActivityCategory> categories) async {
    if (categories.isEmpty) {
      ref.invalidate(categoriesProvider);
      _showMessage('Aún no hay categorías disponibles.');
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
    final activity = _activityById(activities, choice.value);
    setState(() {
      _activityId = choice.value;
      if (activity != null) {
        _categoryId = activity.categoryId;
      }
    });
    if (activity != null) {
      _categoryFieldKey.currentState?.validate();
    }
  }

  Future<void> _start() async {
    final categoryId = _categoryId;
    if (!(_categoryFieldKey.currentState?.validate() ?? false) ||
        categoryId == null) {
      return;
    }
    setState(() => _starting = true);
    final error = await ref
        .read(timerControllerProvider.notifier)
        .start(categoryId: categoryId, activityId: _activityId);
    if (!mounted) {
      return;
    }
    setState(() => _starting = false);
    if (error != null) {
      _showMessage('No se pudo iniciar. ${error.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categories =
        ref.watch(categoriesProvider).value ?? const <ActivityCategory>[];
    final activities =
        ref.watch(openActivitiesProvider).value ?? const <Activity>[];
    final activity = _activityById(activities, _activityId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: KairoSpacing.lg),
        Text(
          '00:00:00',
          textAlign: TextAlign.center,
          style: theme.textTheme.displayMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
        const SizedBox(height: KairoSpacing.sm),
        Text(
          'Elige qué vas a cronometrar y presiona Iniciar.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: KairoSpacing.xl),
        PickerField(
          label: 'Categoría',
          placeholder: 'Selecciona una categoría',
          icon: Icons.category_outlined,
          fieldKey: _categoryFieldKey,
          value: _categoryName(categories, _categoryId),
          validator: () =>
              _categoryId == null ? 'Elige qué vas a cronometrar' : null,
          onTap: () => _pickCategory(categories),
          enabled: !_starting,
        ),
        const SizedBox(height: KairoSpacing.xl),
        PickerField(
          label: 'Actividad (opcional)',
          placeholder: 'Sin actividad',
          icon: Icons.task_alt,
          value: activity?.title,
          onTap: () => _pickActivity(activities),
          onClear: () => setState(() => _activityId = null),
          enabled: !_starting,
        ),
        const SizedBox(height: KairoSpacing.xl),
        FilledButton.icon(
          onPressed: _starting ? null : _start,
          icon: const Icon(Icons.play_arrow_rounded),
          label: const Text('Iniciar'),
        ),
      ],
    );
  }
}

class _RunningTimer extends ConsumerStatefulWidget {
  const _RunningTimer({required this.running, super.key});

  final RunningTimer running;

  @override
  ConsumerState<_RunningTimer> createState() => _RunningTimerState();
}

class _RunningTimerState extends ConsumerState<_RunningTimer> {
  final _noteController = TextEditingController();
  bool _stopping = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _stop(List<ActivityCategory> categories) async {
    FocusScope.of(context).unfocus();
    setState(() => _stopping = true);
    final messenger = ScaffoldMessenger.of(context);
    final note = _noteController.text.trim();
    final result = await ref
        .read(timerControllerProvider.notifier)
        .stop(note: note.isEmpty ? null : note);
    if (mounted) {
      setState(() => _stopping = false);
    }
    final error = result.error;
    final record = result.record;
    final message = error != null
        ? 'No se pudo detener. ${error.message}'
        : record == null
        ? 'El temporizador ya estaba detenido.'
        : 'Guardado: ${DurationFormat.short(record.duration)} de '
              '${_categoryName(categories, record.categoryId) ?? 'tiempo'}.';
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final session = widget.running.session;
    final categories =
        ref.watch(categoriesProvider).value ?? const <ActivityCategory>[];
    final activities =
        ref.watch(openActivitiesProvider).value ?? const <Activity>[];
    final activity = _activityById(activities, session.activityId);
    final category = _categoryName(categories, session.categoryId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: KairoSpacing.lg),
        ElapsedClock(
          running: widget.running,
          style: theme.textTheme.displayMedium?.copyWith(
            color: scheme.primary,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
        const SizedBox(height: KairoSpacing.sm),
        Text(
          'En curso desde las ${DueLabel.hour(session.startedAt.toLocal())}',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: KairoSpacing.xl),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(KairoSpacing.lg),
            child: Row(
              children: [
                Icon(Icons.timer_outlined, color: scheme.secondary),
                const SizedBox(width: KairoSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category ?? 'Categoría',
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: KairoSpacing.xs),
                      Text(
                        activity?.title ?? 'Sin actividad',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: KairoSpacing.xl),
        KairoTextField(
          label: 'Nota (opcional)',
          controller: _noteController,
          hint: 'Qué hiciste en este tiempo',
          keyboardType: TextInputType.multiline,
          minLines: 2,
          maxLines: 4,
          enabled: !_stopping,
        ),
        const SizedBox(height: KairoSpacing.xl),
        FilledButton.icon(
          onPressed: _stopping ? null : () => _stop(categories),
          icon: const Icon(Icons.stop_rounded),
          label: const Text('Detener y guardar'),
        ),
      ],
    );
  }
}
