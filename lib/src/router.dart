import 'package:go_router/go_router.dart';
import 'package:statiescan/src/screens/home_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder:
          (context, state) => const NoTransitionPage(child: HomeScreen()),
    ),
  ],
);
