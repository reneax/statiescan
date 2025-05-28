import 'package:flutter/material.dart';
import 'package:statiescan/src/utils/date_utilities.dart';

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
              DateUtilities.getExpiryText(expiresAt),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(150),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
