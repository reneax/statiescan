import 'package:flutter/material.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';

class NoReceiptsHint extends StatelessWidget {
  const NoReceiptsHint({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.noReceiptsFound,
            style: theme.textTheme.titleMedium,
          ),
          Text(
            AppLocalizations.of(context)!.addNewReceiptHint,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
