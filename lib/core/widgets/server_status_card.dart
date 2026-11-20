import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/api/health_api.dart';
import 'package:kairo/core/theme/kairo_colors.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';

class ServerStatusCard extends ConsumerWidget {
  const ServerStatusCard({super.key});

  static const _unexpectedStatus =
      'El servidor respondió con un estado inesperado.';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(healthStatusProvider);
    final theme = Theme.of(context);
    final success = theme.brightness == Brightness.dark
        ? KairoDarkColors.success
        : KairoColors.success;

    void retry() => ref.invalidate(healthStatusProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(KairoSpacing.lg),
        child: switch (status) {
          AsyncData(:final value) when value.status == 'healthy' => _StatusRow(
            icon: Icons.check_circle,
            color: success,
            message: 'Servidor disponible',
          ),
          AsyncData() => _StatusError(
            message: _unexpectedStatus,
            onRetry: retry,
          ),
          AsyncError(:final error) => _StatusError(
            message: toAppException(error).message,
            onRetry: retry,
          ),
          _ => const _StatusLoading(),
        },
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({
    required this.icon,
    required this.color,
    required this.message,
  });

  final IconData icon;
  final Color color;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: KairoSpacing.md),
        Expanded(
          child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}

class _StatusError extends StatelessWidget {
  const _StatusError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StatusRow(
          icon: Icons.error,
          color: Theme.of(context).colorScheme.error,
          message: message,
        ),
        const SizedBox(height: KairoSpacing.sm),
        TextButton(onPressed: onRetry, child: const Text('Reintentar')),
      ],
    );
  }
}

class _StatusLoading extends StatelessWidget {
  const _StatusLoading();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox.square(
          dimension: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        const SizedBox(width: KairoSpacing.md),
        Expanded(
          child: Text(
            'Conectando con el servidor…',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
