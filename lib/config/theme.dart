import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

class AppTheme {
  static const Color primaryGreen = Color(0xFF2D8659);
  static const Color primaryDarkGreen = Color(0xFF1B5135);
  static const Color accentOrange = Color(0xFFE8793A);
  static const Color bgLight = Color(0xFFFAFAFA);
  static const Color bgDark = Color(0xFF121212);
  static const Color textDark = Color(0xFF1F1F1F);
  static const Color textLight = Color(0xFFFAFAFA);
  static const Color textGrey = Color(0xFF757575);
  static const Color borderGrey = Color(0xFFE0E0E0);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryGreen,
    scaffoldBackgroundColor: bgLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryGreen,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    textTheme: _buildTextTheme(textDark),
    inputDecorationTheme: _buildInputTheme(false),
    elevatedButtonTheme: _buildElevatedButtonTheme(),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      brightness: Brightness.light,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryGreen,
    scaffoldBackgroundColor: bgDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryDarkGreen,
      foregroundColor: textLight,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textLight,
      ),
    ),
    textTheme: _buildTextTheme(textLight),
    inputDecorationTheme: _buildInputTheme(true),
    elevatedButtonTheme: _buildElevatedButtonTheme(),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      brightness: Brightness.dark,
    ),
  );

  static TextTheme _buildTextTheme(Color textColor) {
    return TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: textColor, fontFamily: 'Poppins'),
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: textColor, fontFamily: 'Poppins'),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textColor, fontFamily: 'Poppins'),
      titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textColor, fontFamily: 'Poppins'),
      titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textColor, fontFamily: 'Poppins'),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: textColor, fontFamily: 'Poppins'),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: textColor, fontFamily: 'Poppins'),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: textColor, fontFamily: 'Poppins'),
    );
  }

  static InputDecorationTheme _buildInputTheme(bool isDark) {
    return InputDecorationTheme(
      filled: true,
      fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: isDark ? Colors.grey[700]! : borderGrey)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: isDark ? Colors.grey[700]! : borderGrey)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: primaryGreen, width: 2)),
      labelStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}