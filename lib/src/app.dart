import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:provider/provider.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';
import 'package:statiescan/src/providers/preferences_provider.dart';
import 'package:statiescan/src/providers/ui_state_provider.dart';
import 'package:statiescan/src/router.dart';
import 'package:statiescan/src/services/notification_service.dart';
import 'package:statiescan/src/theme.dart';
import 'package:statiescan/src/utils/image_cache.dart';

class StatiescanApp extends StatefulWidget {
  const StatiescanApp({super.key});

  @override
  State<StatiescanApp> createState() => _StatiescanAppState();
}

class _StatiescanAppState extends State<StatiescanApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ImageCacheHelper(context).cacheImages();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UIStateProvider()),
        ChangeNotifierProvider(create: (_) => PreferencesProvider()),
        Provider<NotificationService>(
          create: (context) => NotificationService(),
        ),
        Provider<AppDatabase>(
          create: (context) => AppDatabase(),
          dispose: (context, db) => db.close(),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, preferencesProvider, child) {
          return MaterialApp.router(
            title: 'Statiescan',
            locale: preferencesProvider.localeObject,
            localizationsDelegates: [
              ...AppLocalizations.localizationsDelegates,
              LocaleNamesLocalizationsDelegate(),
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            themeMode: ThemeMode.values.firstWhere(
              (theme) => theme.name == preferencesProvider.theme,
              orElse: () => ThemeMode.system,
            ),
            routerConfig: appRouter,
            theme: appTheme(Brightness.light),
            darkTheme: appTheme(Brightness.dark),
          );
        },
      ),
    );
  }
}
