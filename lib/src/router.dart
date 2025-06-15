import 'package:go_router/go_router.dart';
import 'package:statiescan/src/repositories/settings/app_settings.dart';
import 'package:statiescan/src/screens/create/create_receipt_screen.dart';
import 'package:statiescan/src/screens/details/receipt_details_screen.dart';
import 'package:statiescan/src/screens/intro/intro_screen.dart';
import 'package:statiescan/src/screens/receipts/receipts_screen.dart';
import 'package:statiescan/src/screens/scan/scan_screen.dart';
import 'package:statiescan/src/screens/settings/settings_screen.dart';
import 'package:statiescan/src/widgets/default_screen_scaffold.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppSettings.isIntroShown.get() ? "/receipts" : "/intro",
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return DefaultScreenScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/receipts',
          pageBuilder:
              (context, state) =>
                  const NoTransitionPage(child: ReceiptsScreen()),
        ),
        GoRoute(
          name: 'receiptDetails',
          path: '/details/:id',
          builder: (context, state) {
            final receiptId = int.parse(state.pathParameters['id']!);

            return ReceiptDetailsScreen(receiptId: receiptId);
          },
        ),
        GoRoute(
          path: '/settings',
          pageBuilder:
              (context, state) =>
                  const NoTransitionPage(child: SettingsScreen()),
        ),
      ],
    ),
    GoRoute(
      name: 'createReceipt',
      path: '/create',
      pageBuilder: (context, state) {
        final barcode = state.uri.queryParameters['barcode']!;
        final typeId = state.uri.queryParameters['type']!;
        final amount = state.uri.queryParameters['amount'];

        return NoTransitionPage(
          child: CreateReceiptScreen(
            barcode: barcode,
            amountInCents: amount != null ? int.tryParse(amount) : null,
            typeId: int.parse(typeId),
          ),
        );
      },
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
