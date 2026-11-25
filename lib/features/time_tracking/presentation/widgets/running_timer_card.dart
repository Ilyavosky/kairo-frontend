import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/features/activities/data/categories_api.dart';
import 'package:kairo/features/activities/data/models/activity_category.dart';
import 'package:kairo/features/time_tracking/domain/duration_format.dart';
import 'package:kairo/features/time_tracking/presentation/controllers/timer_controller.dart';
import 'package:kairo/features/time_tracking/presentation/widgets/elapsed_clock.dart';

class RunningTimerCard extends ConsumerStatefulWidget {
  const RunningTimerCard({required this.timePath, super.key});

  final String timePath;

  @override
  ConsumerState<RunningTimerCard> createState() => _RunningTimerCardState();
}

class _RunningTimerCardState extends ConsumerState<RunningTimerCard> {
  late final AppLifecycleListener _lifecycle;
  bool _stopping = false;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(
      onResume: () => ref.read(timerControllerProvider.notifier).refresh(),
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  Future<void> _stop(String categoryName) async {
    setState(() => _stopping = true);
    final messenger = ScaffoldMessenger.of(context);
    final result = await ref.read(timerControllerProvider.notifier).stop();
    if (mounted) {
      setState(() => _stopping = false);
    }
    final error = result.error;
    final record = result.record;
    final message = error != null
        ? 'No se pudo detener. ${error.message}'
        : record == null
        ? 'El temporizador ya estaba detenido.'
        : 'Guardado: ${DurationFormat.short(record.duration)} '
              'de $categoryName.';
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final running = ref.watch(timerControllerProvider).value?.running;
    if (running == null) {
      return const SizedBox.shrink();
    }
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    var categoryName = 'tiempo';
    final categories =
        ref.watch(categoriesProvider).value ?? const <ActivityCategory>[];
    for (final category in categories) {
      if (category.id == running.session.categoryId) {
        categoryName = category.name;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: KairoSpacing.xl),
      child: Card(
        color: scheme.primaryContainer,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.go(widget.timePath),
          child: Padding(
            padding: const EdgeInsets.all(KairoSpacing.lg),
            child: Row(
              children: [
                Icon(Icons.timer_outlined, color: scheme.onPrimaryContainer),
                const SizedBox(width: KairoSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cronometrando $categoryName',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: scheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: KairoSpacing.xs),
                      ElapsedClock(
                        running: running,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: scheme.onPrimaryContainer,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                    ],
                  ),
                ),
                FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(88, 44),
                  ),
                  onPressed: _stopping ? null : () => _stop(categoryName),
                  child: const Text('Detener'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
