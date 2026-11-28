import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/router/app_routes.dart';
import 'package:kairo/core/storage/session_controller.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/confirm_dialog.dart';
import 'package:kairo/core/widgets/error_view.dart';
import 'package:kairo/core/widgets/kairo_header.dart';
import 'package:kairo/features/account/presentation/controllers/account_controller.dart';
import 'package:kairo/features/activities/domain/due_label.dart';
import 'package:kairo/features/auth/data/models/user_response.dart';
import 'package:kairo/features/auth/domain/timezone_label.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  Future<void> _signOut(BuildContext context, WidgetRef ref) async {
    final confirmed = await showConfirmDialog(
      context,
      title: '¿Cerrar sesión?',
      message: 'Tendrás que volver a ingresar tu correo y contraseña.',
      confirmLabel: 'Cerrar sesión',
    );
    if (confirmed) {
      await ref.read(sessionControllerProvider.notifier).signOut();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(accountProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KairoHeader(
          title: 'Mi cuenta',
          onBack: () => context.pop(),
          showProfile: false,
        ),
        Expanded(
          child: switch (account) {
            AsyncData(:final value) => _content(context, ref, value),
            AsyncError(:final error) => ErrorView(
              message: toAppException(error).message,
              onRetry: () => ref.invalidate(accountProvider),
            ),
            _ => const Center(
              child: CircularProgressIndicator(semanticsLabel: 'Cargando'),
            ),
          },
        ),
      ],
    );
  }

  Widget _content(BuildContext context, WidgetRef ref, UserResponse user) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final name = user.name.trim();
    final initial = name.isEmpty ? '?' : name.characters.first.toUpperCase();
    final linked = user.telegramId != null;
    final registered = user.registeredAt.toLocal();

    return RefreshIndicator(
      onRefresh: () => ref.refresh(accountProvider.future),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          KairoSpacing.page,
          KairoSpacing.md,
          KairoSpacing.page,
          96,
        ),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(KairoSpacing.lg),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: scheme.primary,
                    child: Text(
                      initial,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: scheme.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: KairoSpacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: theme.textTheme.titleMedium),
                        const SizedBox(height: KairoSpacing.xs),
                        Text(user.email, style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: KairoSpacing.lg),
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.public, color: scheme.primary),
                  title: const Text('Zona horaria'),
                  subtitle: Text(
                    '${TimezoneLabel.city(user.timezone)} '
                    '(${user.timezone})',
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.event_available, color: scheme.primary),
                  title: const Text('Cuenta creada'),
                  subtitle: Text(
                    '${DueLabel.dayMonth(registered)} ${registered.year}',
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.send_outlined, color: scheme.primary),
                  title: const Text('Telegram'),
                  subtitle: Text(linked ? 'Vinculado' : 'Sin vincular'),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: scheme.onSurfaceVariant,
                  ),
                  onTap: () => context.go(AppRoutes.telegram),
                ),
              ],
            ),
          ),
          const SizedBox(height: KairoSpacing.sm),
          Text(
            'Las fechas y horas de tus actividades, recordatorios y reportes '
            'se calculan con esta zona horaria.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: KairoSpacing.xl),
          OutlinedButton.icon(
            onPressed: () => _signOut(context, ref),
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }
}
