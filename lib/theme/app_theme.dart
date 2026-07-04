import 'package:flutter/material.dart';

/// Raccoon Timer palette — dark first, cyan for interactive, gold for the
/// "next trigger" hero. Mirrors the approved mockup.
class AppColors {
  static const bg = Color(0xFF0E1116);
  static const surface = Color(0xFF171B22);
  static const elevated = Color(0xFF1E242F);
  static const line = Color(0xFF262D3A);

  static const cyan = Color(0xFF38BDF8);
  static const gold = Color(0xFFF5C542);

  static const text = Color(0xFFE7ECF3);
  static const muted = Color(0xFF8A93A3);
  static const faint = Color(0xFF5A6373);

  // semantic (separate from accent)
  static const good = Color(0xFF34D399);
  static const warn = Color(0xFFF5C542);
  static const bad = Color(0xFFF87171);
}

/// Monospace, tabular figures for every countdown/clock number.
const kMonoFont = 'monospace';

ThemeData buildDarkTheme() {
  final base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: const ColorScheme.dark(
      surface: AppColors.surface,
      primary: AppColors.cyan,
      secondary: AppColors.gold,
      onPrimary: Color(0xFF04222F),
      onSecondary: Color(0xFF3A2F06),
      error: AppColors.bad,
    ),
    dividerColor: AppColors.line,
    textTheme: base.textTheme.apply(
      bodyColor: AppColors.text,
      displayColor: AppColors.text,
    ),
    cardTheme: const CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        side: BorderSide(color: AppColors.line),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.bg,
      elevation: 0,
      centerTitle: false,
      foregroundColor: AppColors.text,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.cyan,
        foregroundColor: const Color(0xFF04222F),
        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),
  );
}

/// Reusable text style for countdown numbers.
const kCountdownStyle = TextStyle(
  fontFamily: kMonoFont,
  fontFeatures: [FontFeature.tabularFigures()],
  color: AppColors.gold,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.5,
);
