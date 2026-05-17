import 'package:flutter/material.dart';

class AppColors {
  // Game-style primary colors
  static const Color primary = Color(0xFF6C5CE7);
  static const Color secondary = Color(0xFFA29BFE);
  static const Color background = Color(0xFF1A1A2E);
  static const Color surface = Color(0xFF16213E);
  static const Color card = Color(0xFF0F3460);

  // Mood colors
  static const Color happy = Color(0xFFFFD93D);
  static const Color neutral = Color(0xFF878D93);
  static const Color sad = Color(0xFF74B9FF);

  // Mood gradient colors
  static const List<Color> happyGradient = [Color(0xFFFFD93D), Color(0xFFFF9A3C)];
  static const List<Color> neutralGradient = [Color(0xFFDEE2E6), Color(0xFF6C757D)];
  static const List<Color> sadGradient = [Color(0xFF74B9FF), Color(0xFF0984E3)];

  // Text colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB2B2B2);

  // Accent
  static const Color accent = Color(0xFFE94560);
  static const Color success = Color(0xFF00D9FF);
}

class AppTheme {
  static const String fontFamily = 'Fredoka';

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.sad,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: fontFamily,
          color: AppColors.textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
        headlineMedium: TextStyle(
          fontFamily: fontFamily,
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          fontFamily: fontFamily,
          color: AppColors.textPrimary,
          fontSize: 18,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontFamily,
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
      ),
    );
  }
}
