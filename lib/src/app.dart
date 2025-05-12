import 'package:flutter/material.dart';
import 'package:statiescan/src/router.dart';
import 'package:statiescan/src/theme.dart';

class StatiescanApp extends StatelessWidget {
  const StatiescanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Statiescan',
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
      theme: appTheme(Brightness.light),
      darkTheme: appTheme(Brightness.dark),
    );
  }
}
