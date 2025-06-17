import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/utils/amount_formatter.dart';
import 'package:statiescan/src/widgets/icon_text.dart';

class ShowStatisticsDialog extends StatefulWidget {
  const ShowStatisticsDialog({super.key});

  @override
  State<ShowStatisticsDialog> createState() => _ShowStatisticsDialogState();
}

class _ShowStatisticsDialogState extends State<ShowStatisticsDialog> {
  int _receiptsAmount = 0;
  int _storesAmount = 0;
  int _redeemedAmountInCents = 0;
  int _availableAmountInCents = 0;
  int _redeemedReceipts = 0;

  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeState();
  }

  Future<void> _initializeState() async {
    final database = context.read<AppDatabase>();

    final receipts = await database.select(database.receipts).get();
    final stores = await database.select(database.stores).get();
    final availableReceipts = receipts.where(
      (receipt) => receipt.deletedAt == null,
    );
    final notExpiredReceipts = availableReceipts.where((receipt) {
      final expiresAt = receipt.expiresAt;

      if (expiresAt == null) {
        return true;
      }

      return DateTime.now().isBefore(expiresAt);
    });
    final redeemedReceipts = receipts.where((receipt) {
      final deletedAt = receipt.deletedAt;
      final expiresAt = receipt.expiresAt;

      if (deletedAt == null || expiresAt == null) {
        return false;
      }

      return deletedAt.isBefore(expiresAt);
    });

    setState(() {
      _receiptsAmount = notExpiredReceipts.length;
      _storesAmount = stores.length;
      _redeemedAmountInCents = redeemedReceipts.fold(
        0,
        (sum, receipt) => sum + (receipt.amountInCents),
      );
      _availableAmountInCents = notExpiredReceipts.fold(
        0,
        (sum, receipt) => sum + (receipt.amountInCents),
      );
      _redeemedReceipts = redeemedReceipts.length;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Statistieken'),
      content:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: ListBody(
                  children: [
                    IconText(
                      iconData: Icons.store,
                      text: 'Aantal winkels: $_storesAmount',
                    ),
                    IconText(
                      iconData: Icons.receipt_long,
                      text: 'Inleverbare bonnen: $_receiptsAmount',
                    ),
                    IconText(
                      iconData: Icons.check,
                      text: 'Ingeleverde bonnen: $_redeemedReceipts',
                    ),
                    IconText(
                      iconData: Icons.access_time,
                      text:
                          "Beschikbaar bedrag: €${AmountFormatter.amountToString(_availableAmountInCents)}",
                    ),
                    IconText(
                      iconData: Icons.euro,
                      text:
                          'Verkregen bedrag: €${AmountFormatter.amountToString(_redeemedAmountInCents)}',
                    ),
                  ],
                ),
              ),
      actions: [
        TextButton(
          child: const Text('Sluiten'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
