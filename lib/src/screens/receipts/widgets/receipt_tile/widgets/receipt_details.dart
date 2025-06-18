import 'package:flutter/material.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';
import 'package:statiescan/src/utils/convert_utils.dart';

class ReceiptDetails extends StatelessWidget {
  final DateTime? expiresAt;
  final String amountString;

  const ReceiptDetails({
    super.key,
    required this.amountString,
    required this.expiresAt,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "€$amountString",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              ConvertUtils.getLocalizedExpiryText(
                AppLocalizations.of(context)!,
                Localizations.localeOf(context),
                expiresAt,
                true,
              ),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(150),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
