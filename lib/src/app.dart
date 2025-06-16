import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/providers/ui_state_provider.dart';
import 'package:statiescan/src/router.dart';
import 'package:statiescan/src/services/notification_service.dart';
import 'package:statiescan/src/theme.dart';
import 'package:statiescan/src/utils/image_cache.dart';

class StatiescanApp extends StatelessWidget {
  const StatiescanApp({super.key});

  @override
  Widget build(BuildContext context) {
    ImageCacheHelper(context).cacheImages();
    initializeDateFormatting('nl');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UIStateProvider()),
        Provider<NotificationService>(
          create: (context) => NotificationService(),
        ),
        Provider<AppDatabase>(
          create: (context) => AppDatabase(),
          dispose: (context, db) => db.close(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Statiescan',
        themeMode: ThemeMode.system,
        routerConfig: appRouter,
        theme: appTheme(Brightness.light),
        darkTheme: appTheme(Brightness.dark),
      ),
    );
  }
}
