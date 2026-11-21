import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';

class KairoTextField extends StatelessWidget {
  const KairoTextField({
    required this.label,
    required this.controller,
    this.hint,
    this.icon,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.onFieldSubmitted,
    this.suffix,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.helperText,
    super.key,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final IconData? icon;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onFieldSubmitted;
  final Widget? suffix;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.titleSmall?.copyWith(fontSize: 16)),
        const SizedBox(height: KairoSpacing.sm),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          autofillHints: autofillHints,
          onFieldSubmitted: onFieldSubmitted,
          enabled: enabled,
          readOnly: readOnly,
          onTap: onTap,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hint,
            helperText: helperText,
            prefixIcon: icon == null
                ? null
                : Icon(icon, color: theme.colorScheme.primary),
            suffixIcon: suffix,
          ),
        ),
      ],
    );
  }
}
