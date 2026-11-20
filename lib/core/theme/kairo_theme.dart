import 'package:flutter/material.dart';
import 'package:kairo/core/theme/kairo_colors.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';

abstract final class KairoTheme {
  static const fontFamily = 'Inter';

  static ThemeData get light => _build(
    const ColorScheme.light(
      primary: KairoColors.primary,
      secondary: KairoColors.accent,
      error: KairoColors.error,
      onSurface: KairoColors.textPrimary,
      onSurfaceVariant: KairoColors.textSecondary,
      surfaceContainerLowest: KairoColors.surface,
      surfaceContainerLow: KairoColors.navBackground,
      outline: KairoColors.chipBorder,
      outlineVariant: KairoColors.navBorder,
    ),
    muted: KairoColors.textMuted,
    cardBorder: KairoColors.surfaceBorder,
  );

  static ThemeData get dark => _build(
    const ColorScheme.dark(
      primary: KairoDarkColors.primary,
      onPrimary: KairoDarkColors.onPrimary,
      secondary: KairoDarkColors.accent,
      error: KairoDarkColors.error,
      onError: KairoDarkColors.onError,
      surface: KairoDarkColors.background,
      onSurface: KairoDarkColors.textPrimary,
      onSurfaceVariant: KairoDarkColors.textSecondary,
      surfaceContainerLowest: KairoDarkColors.surface,
      surfaceContainerLow: KairoDarkColors.navBackground,
      outline: KairoDarkColors.chipBorder,
      outlineVariant: KairoDarkColors.navBorder,
    ),
    muted: KairoDarkColors.textMuted,
    cardBorder: KairoDarkColors.surfaceBorder,
  );

  static ThemeData _build(
    ColorScheme scheme, {
    required Color muted,
    required Color cardBorder,
  }) {
    final fieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(KairoSpacing.radiusSm),
      borderSide: BorderSide(color: scheme.secondary, width: 1.5),
    );
    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(KairoSpacing.radiusMd),
    );

    return ThemeData(
      colorScheme: scheme,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: _textTheme(scheme),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: KairoSpacing.lg,
          vertical: 14,
        ),
        hintStyle: TextStyle(color: muted, fontSize: 15),
        errorStyle: TextStyle(color: scheme.error, fontSize: 14),
        border: fieldBorder,
        enabledBorder: fieldBorder,
        focusedBorder: fieldBorder.copyWith(
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
        errorBorder: fieldBorder.copyWith(
          borderSide: BorderSide(color: scheme.error, width: 1.5),
        ),
        focusedErrorBorder: fieldBorder.copyWith(
          borderSide: BorderSide(color: scheme.error, width: 2),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          minimumSize: const Size.fromHeight(KairoSpacing.buttonHeight),
          shape: buttonShape,
          textStyle: _buttonText,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          minimumSize: const Size.fromHeight(48),
          side: BorderSide(color: scheme.primary, width: 1.5),
          shape: buttonShape,
          textStyle: _buttonText,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.secondary,
          minimumSize: const Size(48, KairoSpacing.touchTarget),
          textStyle: _buttonText,
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surfaceContainerLowest,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KairoSpacing.radiusMd),
          side: BorderSide(color: cardBorder),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
    );
  }

  static const _buttonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static TextTheme _textTheme(ColorScheme scheme) {
    return TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: scheme.onSurface,
      ),
      titleLarge: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w600,
        color: scheme.onSurface,
      ),
      titleMedium: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: scheme.primary,
      ),
      titleSmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: scheme.primary,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: scheme.onSurface),
      bodyMedium: TextStyle(fontSize: 15, color: scheme.onSurface),
      bodySmall: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: scheme.primary,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: scheme.onSurfaceVariant,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: scheme.onSurfaceVariant,
      ),
    );
  }
}
