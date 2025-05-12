import 'package:go_router/go_router.dart';
import 'package:statiescan/src/screens/receipts_screen.dart';
import 'package:statiescan/src/screens/settings/settings_screen.dart';
import 'package:statiescan/src/widgets/default_screen_scaffold.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return DefaultScreenScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SettingsScreen(),
          ),
        ),
      ],
    ),
  ],
);
