import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';

class GoalStatus extends StatelessWidget {
  const GoalStatus({
    required this.achieved,
    required this.pendingLabel,
    this.pendingIcon = Icons.radio_button_unchecked,
    super.key,
  });

  final bool achieved;
  final String pendingLabel;
  final IconData pendingIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final color = achieved ? scheme.primary : scheme.onSurfaceVariant;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          achieved ? Icons.check_circle : pendingIcon,
          size: 18,
          color: color,
        ),
        const SizedBox(width: KairoSpacing.xs),
        Text(
          achieved ? 'Cumplida' : pendingLabel,
          style: theme.textTheme.labelMedium?.copyWith(color: color),
        ),
      ],
    );
  }
}
