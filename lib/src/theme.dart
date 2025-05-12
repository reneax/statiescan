import 'package:flutter/material.dart';

ThemeData appTheme(Brightness brightness) => ThemeData(
  brightness: brightness,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: brightness,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor:
    (brightness == Brightness.dark ? Color(0xFF1E1E1E) : Colors.blue),
    foregroundColor: Colors.white,
    elevation: 4,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),

  ),
);