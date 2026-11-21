import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';

class FormErrorMessage extends StatelessWidget {
  const FormErrorMessage({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.error;

    return Semantics(
      liveRegion: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error, color: color, size: 20),
          const SizedBox(width: KairoSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodySmall?.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
