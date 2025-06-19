import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';
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
  int _averageAmountInCents = 0;
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
      _averageAmountInCents =
          receipts.isNotEmpty
              ? receipts.fold(
                    0,
                    (sum, receipt) => sum + receipt.amountInCents,
                  ) ~/
                  receipts.length
              : 0;
      _redeemedReceipts = redeemedReceipts.length;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.statisticsTitle),
      content:
          _isLoading
              ? IconText(
                iconData: Icons.downloading,
                text: AppLocalizations.of(context)!.loadingStatistics,
              )
              : SingleChildScrollView(
                child: ListBody(
                  children: [
                    IconText(
                      iconData: Icons.store,
                      text: AppLocalizations.of(
                        context,
                      )!.storeCount(_storesAmount),
                    ),
                    IconText(
                      iconData: Icons.receipt_long,
                      text: AppLocalizations.of(
                        context,
                      )!.redeemableReceipts(_receiptsAmount),
                    ),
                    IconText(
                      iconData: Icons.check,
                      text: AppLocalizations.of(
                        context,
                      )!.redeemedReceipts(_redeemedReceipts),
                    ),
                    IconText(
                      iconData: Icons.access_time,
                      text: AppLocalizations.of(context)!.availableAmount(
                        AmountFormatter.amountToString(_availableAmountInCents),
                      ),
                    ),
                    IconText(
                      iconData: Icons.euro,
                      text: AppLocalizations.of(context)!.redeemedAmount(
                        AmountFormatter.amountToString(_redeemedAmountInCents),
                      ),
                    ),
                    IconText(
                      iconData: Icons.stacked_line_chart,
                      text: AppLocalizations.of(
                        context,
                      )!.averageAmountPerReceipt(
                        AmountFormatter.amountToString(_averageAmountInCents),
                      ),
                    ),
                  ],
                ),
              ),
      actions: [
        TextButton(
          child: Text(AppLocalizations.of(context)!.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
