import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({
    required this.title,
    required this.child,
    this.subtitle,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = subtitle;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(KairoSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: theme.textTheme.titleMedium),
            if (text != null) ...[
              const SizedBox(height: KairoSpacing.xs),
              Text(text, style: theme.textTheme.bodySmall),
            ],
            const SizedBox(height: KairoSpacing.lg),
            child,
          ],
        ),
      ),
    );
  }
}
