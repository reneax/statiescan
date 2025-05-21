import 'package:flutter/material.dart';

ThemeData appTheme(Brightness brightness) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: brightness,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,
    appBarTheme: AppBarTheme(
      elevation: 4,
    ),
  );
}
