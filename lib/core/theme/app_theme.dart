import 'package:flutter/material.dart';

class AppTheme {
  // Define our specific app colors
  static const Color surfaceDark = Color(0xFF1E1E2C);
  static const Color backgroundDark = Color(0xFF12121A);
  static const Color textPrimary = Colors.white;

  // Define the overall theme for the app
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundDark,
    primaryColor: Colors.blueAccent,

    // Default App Bar styling
    appBarTheme: const AppBarTheme(
      backgroundColor: surfaceDark,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Default Card styling using the correct data class for newer Flutter versions
    cardTheme: CardThemeData(
      color: surfaceDark,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
