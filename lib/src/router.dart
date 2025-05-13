import 'package:go_router/go_router.dart';
import 'package:statiescan/src/screens/receipts_screen.dart';
import 'package:statiescan/src/screens/settings/settings_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder:
          (context, state) => const NoTransitionPage(child: HomeScreen()),
    ),
    GoRoute(
      path: '/settings',
      pageBuilder:
          (context, state) => const NoTransitionPage(child: SettingsScreen()),
    ),
  ],
);
