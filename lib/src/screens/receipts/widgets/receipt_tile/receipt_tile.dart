import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/screens/receipts/widgets/receipt_tile/widgets/barcode_widget.dart';
import 'package:statiescan/src/screens/receipts/widgets/receipt_tile/widgets/receipt_details.dart';
import 'package:statiescan/src/utils/amount_formatter.dart';
import 'package:statiescan/src/utils/convert_utils.dart';

class ReceiptTile extends StatelessWidget {
  final Receipt receipt;

  const ReceiptTile({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap:
            () => context.pushNamed(
              "receiptDetails",
              pathParameters: {"id": receipt.id.toString()},
            ),
        borderRadius: BorderRadius.circular(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                ReceiptBarcode(
                  code: receipt.code,
                  type: ConvertUtils.getBarcodeType(receipt.typeId),
                ),
                ReceiptDetails(
                  amountString: AmountFormatter.amountToString(
                    receipt.amountInCents,
                  ),
                  expiresAt: receipt.expiresAt,
                ),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
