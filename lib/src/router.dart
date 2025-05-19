import 'package:go_router/go_router.dart';
import 'package:statiescan/src/repositories/settings/app_settings.dart';
import 'package:statiescan/src/screens/create/create_receipt_screen.dart';
import 'package:statiescan/src/screens/intro/intro_screen.dart';
import 'package:statiescan/src/screens/receipts_screen.dart';
import 'package:statiescan/src/screens/scan/scan_screen.dart';
import 'package:statiescan/src/screens/settings/settings_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppSettings.isIntroShown.get() ? "/receipts" : "/intro",
  routes: [
    GoRoute(
      path: '/receipts',
      pageBuilder:
          (context, state) => const NoTransitionPage(child: ReceiptsScreen()),
    ),
    GoRoute(
      path: '/create',
      pageBuilder: (context, state) {
        final barcode = state.uri.queryParameters['barcode']!;
        final amount = state.uri.queryParameters['amount'];

        return NoTransitionPage(
          child: CreateReceiptScreen(
            barcode: barcode,
            amountInCents: amount != null ? int.tryParse(amount) : null,
          ),
        );
      },
    ),
    GoRoute(
      path: '/settings',
      pageBuilder:
          (context, state) => const NoTransitionPage(child: SettingsScreen()),
    ),
    GoRoute(
      path: '/scan',
      pageBuilder:
          (context, state) => const NoTransitionPage(child: ScanScreen()),
    ),
    GoRoute(
      path: '/intro',
      pageBuilder:
          (context, state) => const NoTransitionPage(child: IntroScreen()),
    ),
  ],
);
