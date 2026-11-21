import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/api/health_api.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/form_error_message.dart';

class ServerStatusCard extends ConsumerWidget {
  const ServerStatusCard({super.key});

  static const _unexpectedStatus =
      'El servidor respondió con un estado inesperado.';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(healthStatusProvider);

    final message = switch (status) {
      AsyncData(:final value) when value.status != 'healthy' =>
        _unexpectedStatus,
      AsyncError(:final error) => toAppException(error).message,
      _ => null,
    };

    if (message == null) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          KairoSpacing.lg,
          KairoSpacing.lg,
          KairoSpacing.sm,
          KairoSpacing.xs,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormErrorMessage(message: message),
            TextButton(
              onPressed: () => ref.invalidate(healthStatusProvider),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
