import 'package:flutter/material.dart';
import 'package:statiescan/src/router.dart';
import 'package:statiescan/src/theme.dart';
import 'package:statiescan/src/utils/image_cache.dart';

import 'database/app_database.dart';

class StatiescanApp extends StatelessWidget {
  const StatiescanApp({super.key});

  @override
  Widget build(BuildContext context) {
    ImageCacheHelper(context).cacheImages();

    return MaterialApp.router(
      title: 'Statiescan',
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
      theme: appTheme(Brightness.light),
      darkTheme: appTheme(Brightness.dark),
    );
  }
}
