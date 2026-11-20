import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';

class KairoHeader extends StatelessWidget {
  const KairoHeader({
    required this.title,
    this.onBack,
    this.onProfileTap,
    super.key,
  });

  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onProfileTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        KairoSpacing.page,
        KairoSpacing.lg,
        KairoSpacing.page - KairoSpacing.sm,
        KairoSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Kairo',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: scheme.secondary,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: onProfileTap,
                tooltip: 'Perfil',
                iconSize: 32,
                color: scheme.primary,
                disabledColor: scheme.primary,
                icon: const Icon(Icons.account_circle),
              ),
            ],
          ),
          const SizedBox(height: KairoSpacing.sm),
          Row(
            children: [
              if (onBack != null) ...[
                IconButton(
                  onPressed: onBack,
                  tooltip: 'Regresar',
                  color: scheme.onSurface,
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: KairoSpacing.xs),
              ],
              Expanded(
                child: Semantics(
                  header: true,
                  child: Text(title, style: theme.textTheme.titleLarge),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
