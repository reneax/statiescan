import 'package:flutter/material.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';
import 'package:statiescan/src/utils/amount_formatter.dart';
import 'package:statiescan/src/utils/convert_utils.dart';
import 'package:statiescan/src/widgets/icon_text.dart';

class ReceiptInformationCard extends StatelessWidget {
  final Receipt receipt;
  final Store store;

  const ReceiptInformationCard({
    super.key,
    required this.receipt,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 10,
          children: [
            IconText(iconData: Icons.store, text: store.name),
            IconText(
              iconData: Icons.euro,
              text: AppLocalizations.of(context)!.amountDescription(
                AmountFormatter.amountToString(receipt.amountInCents),
              ),
            ),
            IconText(
              iconData: Icons.access_time,
              text: ConvertUtils.getLocalizedExpiryText(
                AppLocalizations.of(context)!,
                Localizations.localeOf(context),
                receipt.expiresAt,
                false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
