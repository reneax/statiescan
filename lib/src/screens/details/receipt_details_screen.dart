import 'dart:io';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';
import 'package:statiescan/src/repositories/settings/app_settings.dart';
import 'package:statiescan/src/screens/details/widgets/floating_delete_button.dart';
import 'package:statiescan/src/screens/details/widgets/information_card/actions_row.dart';
import 'package:statiescan/src/screens/details/widgets/information_card/information_card.dart';
import 'package:statiescan/src/services/notification_service.dart';
import 'package:statiescan/src/utils/amount_formatter.dart';
import 'package:statiescan/src/utils/convert_utils.dart';
import 'package:statiescan/src/utils/snackbar_creator.dart';
import 'package:statiescan/src/widgets/barcode_display.dart';
import 'package:statiescan/src/widgets/screen_wrapper.dart';
import 'package:vibration/vibration.dart';

class ReceiptDetailsScreen extends StatefulWidget {
  final int receiptId;

  const ReceiptDetailsScreen({super.key, required this.receiptId});

  @override
  State<ReceiptDetailsScreen> createState() => _ReceiptDetailsScreenState();
}

class _ReceiptDetailsScreenState extends State<ReceiptDetailsScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  Receipt? _receipt;
  Store? _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeState();
  }

  void _initializeState() async {
    final database = context.read<AppDatabase>();

    Receipt fetchedReceipt =
        await (database.select(
          database.receipts,
        )..where((receipt) => receipt.id.equals(widget.receiptId))).getSingle();

    Store fetchedStore =
        await (database.select(database.stores)..where(
          (store) => store.id.equals(fetchedReceipt.storeId),
        )).getSingle();

    setState(() {
      _receipt = fetchedReceipt;
      _store = fetchedStore;
    });
  }

  void _handleShareButton() async {
    final currentReceipt = _receipt;
    final currentStore = _store;

    if (currentReceipt == null || currentStore == null) return;

    final imageBytes = await _screenshotController.captureFromWidget(
      BarcodeDisplay(
        barcode: currentReceipt.code,
        type: ConvertUtils.getBarcodeType(currentReceipt.typeId),
        height: 150,
        width: 300,
      ),
      delay: Duration.zero,
    );

    final tempDir = await getTemporaryDirectory();

    if (!mounted) return;

    final tempFile = File(
      '${tempDir.path}/${AppLocalizations.of(context)!.receiptFileName}.jpg',
    );

    final params = ShareParams(
      text: AppLocalizations.of(context)!.shareMessage(
        AmountFormatter.amountToString(currentReceipt.amountInCents),
        currentStore.name,
      ),
      files: [XFile(tempFile.path)],
    );

    await tempFile.writeAsBytes(imageBytes);

    final result = await SharePlus.instance.share(params);

    if (mounted && result.status == ShareResultStatus.success) {
      SnackbarCreator.show(
        context,
        status: SnackbarStatus.info,
        duration: Duration(seconds: 5),
        message: AppLocalizations.of(context)!.dontForgetDeleteAfterShare,
      );
    }
  }

  void _deleteReceipt() async {
    final currentReceipt = _receipt;
    final currentStore = _store;

    if (currentReceipt == null || currentStore == null) return;

    final database = context.read<AppDatabase>();
    final notificationService = context.read<NotificationService>();

    await (database.update(database.receipts)..where(
      (receipt) => receipt.id.equals(currentReceipt.id),
    )).write(ReceiptsCompanion(deletedAt: drift.Value(DateTime.now())));

    notificationService.cancelNotificationsForReceipt(currentReceipt.id);

    if (!mounted) return;

    if (AppSettings.vibrationEnabled.get()) {
      Vibration.vibrate(duration: 100);
    }

    SnackbarCreator.show(
      context,
      status: SnackbarStatus.success,
      duration: Duration(seconds: 2),
      message: AppLocalizations.of(context)!.receiptDeleteSuccess,
    );

    if (AppSettings.goToNextWhenDeleted.get()) {
      final receipts =
          await (database.select(database.receipts)..where((receipt) {
            final isInStore = receipt.storeId.equals(currentStore.id);
            final isNotDeleted = receipt.deletedAt.isNull();
            final isExpiryNull = receipt.expiresAt.isNull();
            final isNotExpired = receipt.expiresAt.isBiggerThanValue(
              DateTime.now(),
            );

            return isInStore & isNotDeleted & (isExpiryNull | isNotExpired);
          })).get();

      final nextReceipt = receipts.isNotEmpty ? receipts.first : null;

      if (!mounted) return;

      if (nextReceipt != null) {
        context.pushReplacementNamed(
          "receiptDetails",
          pathParameters: {"id": nextReceipt.id.toString()},
        );

        return;
      }
    }

    context.go("/receipts");
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.receiptDetailsTitle),
      ),
      floatingActionButton: FloatingDeleteButton(onDeletePress: _deleteReceipt),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Builder(
            builder: (context) {
              final currentReceipt = _receipt;
              final currentStore = _store;

              if (currentReceipt == null || currentStore == null) {
                return Center(child: CircularProgressIndicator());
              }

              return Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BarcodeDisplay(
                    barcode: currentReceipt.code,
                    type: ConvertUtils.getBarcodeType(currentReceipt.typeId),
                    height: 150,
                    width: 300,
                  ),
                  ReceiptInformationCard(
                    receipt: currentReceipt,
                    store: currentStore,
                  ),
                  ActionsRow(onShareButtonPress: _handleShareButton),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
