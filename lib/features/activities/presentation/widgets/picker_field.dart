import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';

class PickerField extends StatelessWidget {
  const PickerField({
    required this.label,
    required this.placeholder,
    required this.icon,
    required this.onTap,
    this.value,
    this.onClear,
    this.validator,
    this.fieldKey,
    this.enabled = true,
    super.key,
  });

  final String label;
  final String placeholder;
  final IconData icon;
  final VoidCallback onTap;
  final String? value;
  final VoidCallback? onClear;
  final String? Function()? validator;
  final GlobalKey<FormFieldState<String>>? fieldKey;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = value;
    final clear = onClear;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.titleSmall?.copyWith(fontSize: 16)),
        const SizedBox(height: KairoSpacing.sm),
        FormField<String>(
          key: fieldKey,
          validator: (_) => validator?.call(),
          builder: (field) => InkWell(
            onTap: enabled ? onTap : null,
            borderRadius: BorderRadius.circular(KairoSpacing.radiusMd),
            child: InputDecorator(
              isEmpty: text == null,
              decoration: InputDecoration(
                enabled: enabled,
                hintText: placeholder,
                errorText: field.errorText,
                prefixIcon: Icon(icon, color: theme.colorScheme.primary),
                suffixIcon: text != null && clear != null
                    ? IconButton(
                        onPressed: enabled ? clear : null,
                        tooltip: 'Quitar',
                        icon: const Icon(Icons.close),
                      )
                    : const Icon(Icons.expand_more),
              ),
              child: text == null
                  ? null
                  : Text(text, style: theme.textTheme.bodyLarge),
            ),
          ),
        ),
      ],
    );
  }
}

class PickerOption<T> {
  const PickerOption(this.value, this.label);

  final T value;
  final String label;
}

Future<PickerOption<T>?> showPickerSheet<T>(
  BuildContext context, {
  required List<PickerOption<T>> options,
  required T selected,
}) {
  final scheme = Theme.of(context).colorScheme;

  return showModalBottomSheet<PickerOption<T>>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) => SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.6,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            for (final option in options)
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: KairoSpacing.page,
                ),
                title: Text(option.label),
                selected: option.value == selected,
                trailing: option.value == selected
                    ? Icon(Icons.check, color: scheme.primary)
                    : null,
                onTap: () => Navigator.of(context).pop(option),
              ),
          ],
        ),
      ),
    ),
  );
}
