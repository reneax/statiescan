import 'package:flutter/material.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/screens/receipts/widgets/barcode_widget.dart';

class ReceiptTile extends StatelessWidget {
  final Receipt receipt;
  final VoidCallback? onTap;
  final String storeName;

  const ReceiptTile({
    super.key,
    required this.receipt,
    required this.storeName,
    this.onTap,
  });

  String formatDate(DateTime date) =>
      "${date.day.toString().padLeft(2, '0')}/"
      "${date.month.toString().padLeft(2, '0')}/"
      "${date.year}";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.cardColor,
            border: Border.all(color: theme.dividerColor),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              ReceiptBarcode(code: receipt.code),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "€${(receipt.amountInCents / 100).toStringAsFixed(2)}",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    if (receipt.expiresAt != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          "Expires: ${formatDate(receipt.expiresAt!)}",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withAlpha(150),
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
