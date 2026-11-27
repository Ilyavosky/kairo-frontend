import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/confirm_dialog.dart';
import 'package:kairo/core/widgets/empty_state.dart';
import 'package:kairo/core/widgets/error_view.dart';
import 'package:kairo/features/reminders/data/models/reminder.dart';
import 'package:kairo/features/reminders/domain/reminder_groups.dart';
import 'package:kairo/features/reminders/presentation/controllers/reminder_form_controller.dart';
import 'package:kairo/features/reminders/presentation/controllers/reminders_controller.dart';
import 'package:kairo/features/reminders/presentation/widgets/reminder_tile.dart';

class RemindersList extends ConsumerWidget {
  const RemindersList({required this.upcoming, super.key});

  final bool upcoming;

  Future<void> _cancel(
    BuildContext context,
    WidgetRef ref,
    Reminder reminder,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showConfirmDialog(
      context,
      title: '¿Quitar este recordatorio?',
      message: 'Ya no te llegará este aviso por Telegram.',
      confirmLabel: 'Quitar',
    );
    if (!confirmed) {
      return;
    }
    final controller = ref.read(reminderFormControllerProvider.notifier);
    final done = await controller.cancel(reminder.id);
    final error = ref.read(reminderFormControllerProvider).error;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            done || error == null
                ? 'Recordatorio quitado.'
                : toAppException(error).message,
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(reminderFormControllerProvider);
    final reminders = ref.watch(remindersProvider);
    final options = ref.watch(reminderOptionsProvider);
    final names = {
      for (final list in options.values)
        for (final option in list) option.id: option.label,
    };

    return switch (reminders) {
      AsyncData(:final value) => _list(context, ref, value, names),
      AsyncError(:final error) => ErrorView(
        message: toAppException(error).message,
        onRetry: () => ref.invalidate(remindersProvider),
      ),
      _ => const Center(
        child: CircularProgressIndicator(semanticsLabel: 'Cargando'),
      ),
    };
  }

  Widget _list(
    BuildContext context,
    WidgetRef ref,
    List<Reminder> all,
    Map<String, String> names,
  ) {
    final items = upcoming
        ? ReminderGroups.upcoming(all)
        : ReminderGroups.past(all);
    if (items.isEmpty) {
      return upcoming
          ? const EmptyState(
              icon: Icons.notifications_none,
              title: 'No tienes recordatorios próximos',
              message:
                  'Kairo te avisa por Telegram a la hora que elijas. '
                  'Toca + para crear uno.',
            )
          : const EmptyState(
              icon: Icons.history,
              title: 'Aún no hay recordatorios enviados',
              message: 'Aquí verás los avisos que ya te llegaron.',
            );
    }
    return RefreshIndicator(
      onRefresh: () => ref.refresh(remindersProvider.future),
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(
          KairoSpacing.page,
          KairoSpacing.md,
          KairoSpacing.page,
          96,
        ),
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(height: KairoSpacing.sm),
        itemBuilder: (context, index) {
          final reminder = items[index];
          return ReminderTile(
            reminder: reminder,
            title: names[reminder.targetId] ?? reminder.target.label,
            onCancel: upcoming ? () => _cancel(context, ref, reminder) : null,
          );
        },
      ),
    );
  }
}
