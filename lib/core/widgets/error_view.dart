import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/form_error_message.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({required this.message, required this.onRetry, super.key});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(KairoSpacing.page),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FormErrorMessage(message: message),
            const SizedBox(height: KairoSpacing.md),
            OutlinedButton(
              onPressed: onRetry,
              style: OutlinedButton.styleFrom(minimumSize: const Size(160, 48)),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
