import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Premium app theme configuration for light and dark modes
class AppTheme {
  // Primary colors - Modern Blue Palette
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color accent = Color(0xFF03A9F4);

  // Light theme - Premium Design
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: const Color(0xFFF8F9FA),
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: accent,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      error: Color(0xFFE53935),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: Color(0xFFF8F9FA),
      foregroundColor: Color(0xFF1A1A1A),
      iconTheme: IconThemeData(color: Color(0xFF1A1A1A)),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE53935), width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFE53935), width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    ),
    iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -1,
        color: Color(0xFF1A1A1A),
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        color: Color(0xFF1A1A1A),
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        color: Color(0xFF1A1A1A),
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFF424242),
        height: 1.6,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF616161),
        height: 1.5,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey.withOpacity(0.2),
      thickness: 1,
      space: 1,
    ),
  );

  // Dark theme - Premium Design
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: const Color(0xFF0F0F0F),
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: accent,
      surface: Color(0xFF1A1A1A),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      error: Color(0xFFEF5350),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: Color(0xFF0F0F0F),
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: const Color(0xFF1A1A1A),
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1A1A1A),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFEF5350), width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFEF5350), width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -1,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFFE0E0E0),
        height: 1.6,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFFBDBDBD),
        height: 1.5,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.white.withOpacity(0.1),
      thickness: 1,
      space: 1,
    ),
  );
}
