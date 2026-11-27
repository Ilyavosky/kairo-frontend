import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';

class ScalePicker extends StatelessWidget {
  const ScalePicker({
    required this.label,
    required this.labels,
    required this.value,
    required this.onChanged,
    required this.validator,
    this.enabled = true,
    super.key,
  });

  final String label;
  final Map<int, String> labels;
  final int? value;
  final ValueChanged<int> onChanged;
  final String? Function(int?) validator;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final selected = value;

    return FormField<int>(
      validator: (_) => validator(value),
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: theme.textTheme.titleSmall?.copyWith(fontSize: 16),
          ),
          const SizedBox(height: KairoSpacing.sm),
          SegmentedButton<int>(
            showSelectedIcon: false,
            emptySelectionAllowed: true,
            segments: [
              for (final level in labels.keys)
                ButtonSegment(value: level, label: Text('$level')),
            ],
            selected: {?selected},
            onSelectionChanged: enabled
                ? (selection) {
                    if (selection.isNotEmpty) {
                      onChanged(selection.first);
                      field.didChange(selection.first);
                    }
                  }
                : null,
          ),
          const SizedBox(height: KairoSpacing.xs),
          Row(
            children: [
              Text(
                labels[labels.keys.first]!,
                style: theme.textTheme.bodySmall,
              ),
              const Spacer(),
              Text(labels[labels.keys.last]!, style: theme.textTheme.bodySmall),
            ],
          ),
          if (selected != null) ...[
            const SizedBox(height: KairoSpacing.xs),
            Text(
              '$selected · ${labels[selected]}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.primary,
              ),
            ),
          ],
          if (field.errorText != null) ...[
            const SizedBox(height: KairoSpacing.xs),
            Text(
              field.errorText!,
              style: theme.textTheme.bodySmall?.copyWith(color: scheme.error),
            ),
          ],
        ],
      ),
    );
  }
}
