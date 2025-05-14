import 'package:go_router/go_router.dart';
import 'package:statiescan/src/screens/receipts_screen.dart';
import 'package:statiescan/src/screens/settings/settings_screen.dart';
import 'package:statiescan/src/screens/intro/intro_screen.dart';
import 'package:statiescan/src/utils/shared_prefs.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: SharedPrefs.getBool("introShown") ? "/receipts" : "/intro",
  routes: [
    GoRoute(
      path: '/receipts',
      pageBuilder:
          (context, state) => const NoTransitionPage(child: ReceiptsScreen()),
    ),
    GoRoute(
      path: '/settings',
      pageBuilder:
          (context, state) => const NoTransitionPage(child: SettingsScreen()),
    ),
    GoRoute(
      path: '/intro',
      pageBuilder:
          (context, state) => const NoTransitionPage(child: IntroScreen()),
    ),
  ],
);
