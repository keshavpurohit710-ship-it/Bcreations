// Light (default) and dark themes. Large, readable text and big touch targets
// for comfortable everyday use; colours from the Bcreations logo.

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
      bodyLarge: text.bodyLarge?.copyWith(fontSize: 18),
      bodyMedium: text.bodyMedium?.copyWith(fontSize: 16),
      bodySmall: text.bodySmall?.copyWith(fontSize: 14),
      titleLarge: text.titleLarge?.copyWith(fontSize: 22, fontWeight: FontWeight.w600),
      titleMedium: text.titleMedium?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
      labelLarge: text.labelLarge?.copyWith(fontSize: 16),
    ),
    visualDensity: VisualDensity.standard,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    appBarTheme: AppBarTheme(centerTitle: false, backgroundColor: scheme.surface, scrolledUnderElevation: 1),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(64, 52),
        textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(minimumSize: const Size(64, 48), textStyle: const TextStyle(fontSize: 16)),
    ),
    chipTheme: base.chipTheme.copyWith(labelStyle: const TextStyle(fontSize: 15)),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    ),
    listTileTheme: const ListTileThemeData(minVerticalPadding: 12),
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: WidgetStateProperty.all(const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      height: 72,
    ),
  );
}
