import 'package:dragon_design/dragon_design.dart';
import 'package:flutter/material.dart';

/// Centralized light and dark [ThemeData] built on Dragon Design tokens.
abstract final class AppTheme {
  /// Font family bundled in the `dragon_design` package.
  static const _fontFamily =
      'packages/dragon_design/${AppTextStyle.fontFamily}';

  /// Theme used when the platform or user prefers light mode.
  static final ThemeData light = _build(Brightness.light);

  /// Theme used when the platform or user prefers dark mode.
  static final ThemeData dark = _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) => ThemeData(
    useMaterial3: true,
    fontFamily: _fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.primary,
      primary: AppColor.primary,
      secondary: AppColor.secondary,
      tertiary: AppColor.tertiary,
      error: AppColor.error,
      brightness: brightness,
    ),
  );
}
