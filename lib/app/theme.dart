// Light (default) and dark themes. Comfortably readable text and touch targets
// (48 dp+) without wasting space; colours from the Bcreations logo.
//
// Rule: never give a component a TextStyle without a colour — that drops the
// theme's colour and can leave white text on a light background (this happened
// to chips). Only adjust sizes through the text theme.

import 'package:flutter/material.dart';

const brandPurple = Color(0xFF7B3FE4);
const brandOrange = Color(0xFFFF8A3D);

// Status colours (always paired with an icon or word, never colour alone)
const goodColor = Color(0xFF1E8E3E);
const warnColor = Color(0xFFE37400);
const badColor = Color(0xFFD93025);

ThemeData buildTheme(Brightness brightness) {
  final scheme = ColorScheme.fromSeed(
    seedColor: brandPurple,
    secondary: brandOrange,
    brightness: brightness,
  );
  final base = ThemeData(useMaterial3: true, colorScheme: scheme, brightness: brightness);
  final text = base.textTheme;
  return base.copyWith(
    textTheme: text.copyWith(
      bodyLarge: text.bodyLarge?.copyWith(fontSize: 16),
      bodyMedium: text.bodyMedium?.copyWith(fontSize: 15),
      bodySmall: text.bodySmall?.copyWith(fontSize: 13),
      titleLarge: text.titleLarge?.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
      titleMedium: text.titleMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
      titleSmall: text.titleSmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
      labelLarge: text.labelLarge?.copyWith(fontSize: 15),
    ),
    visualDensity: VisualDensity.standard,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    appBarTheme: AppBarTheme(centerTitle: false, backgroundColor: scheme.surface, scrolledUnderElevation: 1),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(minimumSize: const Size(64, 48)),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(minimumSize: const Size(64, 44)),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    ),
    listTileTheme: const ListTileThemeData(minVerticalPadding: 8),
    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: states.contains(WidgetState.selected) ? scheme.onSurface : scheme.onSurfaceVariant,
        ),
      ),
      height: 66,
    ),
  );
}
