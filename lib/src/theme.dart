import 'package:flutter/material.dart';

ThemeData appTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;

  return ThemeData(
    brightness: brightness,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: brightness,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.blue,
      foregroundColor: Colors.white,
      elevation: 2,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
