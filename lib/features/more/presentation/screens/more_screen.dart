import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/router/app_routes.dart';
import 'package:kairo/core/storage/session_controller.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/confirm_dialog.dart';
import 'package:kairo/core/widgets/kairo_header.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const KairoHeader(title: 'Más'),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              KairoSpacing.page,
              KairoSpacing.md,
              KairoSpacing.page,
              KairoSpacing.xl,
            ),
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    _MoreOption(
                      icon: Icons.menu_book,
                      title: 'Materias',
                      subtitle: 'Tus materias del periodo',
                      onTap: () => context.go(AppRoutes.subjects),
                    ),
                    const Divider(height: 1),
                    _MoreOption(
                      icon: Icons.notifications_none,
                      title: 'Recordatorios',
                      subtitle: 'Avisos por Telegram de tus pendientes',
                      onTap: () => context.go(AppRoutes.reminders),
                    ),
                    const Divider(height: 1),
                    _MoreOption(
                      icon: Icons.self_improvement,
                      title: 'Autoevaluación semanal',
                      subtitle: 'Cómo te sentiste cada semana',
                      onTap: () => context.go(AppRoutes.selfAssessment),
                    ),
                    const Divider(height: 1),
                    _MoreOption(
                      icon: Icons.send_outlined,
                      title: 'Telegram',
                      subtitle: 'Vincula el bot de Kairo',
                      onTap: () => context.go(AppRoutes.telegram),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: KairoSpacing.xl),
              OutlinedButton.icon(
                onPressed: () => _signOut(context, ref),
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar sesión'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MoreOption extends StatelessWidget {
  const _MoreOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: KairoSpacing.lg,
        vertical: KairoSpacing.xs,
      ),
      leading: CircleAvatar(
        backgroundColor: scheme.secondary.withValues(alpha: 0.12),
        child: Icon(icon, color: scheme.primary),
      ),
      title: Text(title, style: theme.textTheme.titleSmall),
      subtitle: Text(subtitle, style: theme.textTheme.bodySmall),
      trailing: Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
    );
  }
}
