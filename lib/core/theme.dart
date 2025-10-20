import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AppTheme {
  static const Color kAmber = Color(0xFFFFB300);
  static const Color kDeepGreen = Color(0xFF1B5E20);

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(seedColor: kDeepGreen),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF9F7F3),
      textTheme: _textTheme(Brightness.light),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      cardTheme: const CardThemeData(
        elevation: 0,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: kAmber,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFF0F1214),
      textTheme: _textTheme(Brightness.dark),
      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      cardTheme: const CardThemeData(
        elevation: 0,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }

  static TextTheme _textTheme(Brightness b) {
    const arabicFamily = 'Amiri';
    const englishFamily = 'Merriweather';
    return TextTheme(
      titleLarge: const TextStyle(
          fontFamily: englishFamily, fontWeight: FontWeight.w700, fontSize: 22),
      bodyLarge:
      const TextStyle(fontFamily: englishFamily, fontSize: 16, height: 1.4),
      bodyMedium:
      const TextStyle(fontFamily: englishFamily, fontSize: 14, height: 1.4),
      displayMedium:
      const TextStyle(fontFamily: arabicFamily, fontSize: 26, height: 1.6),
      displaySmall:
      const TextStyle(fontFamily: arabicFamily, fontSize: 22, height: 1.6),
    );
  }
}

