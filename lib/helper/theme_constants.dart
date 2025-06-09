import 'package:flutter/material.dart';

class AppColors {
  // Primärfarben
  static const Color primaryGreen = Color(0xFF528a7d);
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // UI-Farben
  static const Color cardBackground = Colors.white;
  static const Color scaffoldBackground = Color(0xFF528a7d);
}

class AppTheme {
  static ThemeData get defaultTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.white),
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontFamily: 'Poppins', fontSize: 16, color: AppColors.white),
      bodyMedium: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: AppColors.white),
      bodySmall: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: AppColors.white),
    ),
  );
}
