import 'package:flutter/material.dart';

class AppTheme {
  // --- CONSTANT COLORS (Industrial Minimalist Theme) ---
  static const Color bgColor = Color(0xFF0F1117);
  static const Color surfaceColor = Color(0xFF1A1D27);
  static const Color cardColor = Color(0xFF21253A);
  static const Color accentAmber = Color(0xFFF5A623);
  static const Color accentBlue = Color(0xFF3B82F6);
  static const Color textPrimary = Color(0xFFF0F2FF);
  static const Color textSecondary = Color(0xFF8B92A9);
  static const Color statusSuccess = Color(0xFF10B981);
  static const Color statusWarning = Color(0xFFF59E0B);
  static const Color statusDanger = Color(0xFFEF4444);

  // --- GLOBAL THEME DATA ---
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bgColor,
      primaryColor: accentAmber,
      colorScheme: const ColorScheme.dark(
        primary: accentAmber,
        secondary: accentBlue,
        surface: surfaceColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: accentAmber,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    );
  }
}
