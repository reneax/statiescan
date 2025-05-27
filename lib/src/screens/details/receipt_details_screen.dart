import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:statiescan/src/database/app_database.dart';
import 'package:statiescan/src/screens/details/widgets/information_card/actions_row.dart';
import 'package:statiescan/src/screens/details/widgets/information_card/information_card.dart';
import 'package:statiescan/src/utils/amount_formatter.dart';
import 'package:statiescan/src/utils/snackbar_creator.dart';
import 'package:statiescan/src/widgets/barcode_display.dart';
import 'package:statiescan/src/widgets/default_screen_scaffold.dart';

class ReceiptDetailsScreen extends StatefulWidget {
  final int receiptId;

  const ReceiptDetailsScreen({super.key, required this.receiptId});

  @override
  State<ReceiptDetailsScreen> createState() => _ReceiptDetailsScreenState();
}

class _ReceiptDetailsScreenState extends State<ReceiptDetailsScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  final _database = AppDatabase();
  Receipt? _receipt;
  Store? _store;

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  void _initializeState() async {
    Receipt fetchedReceipt =
        await (_database.select(
          _database.receipts,
        )..where((receipt) => receipt.id.equals(widget.receiptId))).getSingle();

    Store fetchedStore =
        await (_database.select(_database.stores)..where(
          (store) => store.id.equals(fetchedReceipt.storeId),
        )).getSingle();

    setState(() {
      _receipt = fetchedReceipt;
      _store = fetchedStore;
    });
  }

  void _handleShareButton() async {
    if (_receipt == null || _store == null) return;

    final imageBytes = await _screenshotController.captureFromWidget(
      BarcodeDisplay(barcode: _receipt!.code, height: 150, width: 300),
      delay: Duration.zero,
    );

    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/emballage.jpg');

    await tempFile.writeAsBytes(imageBytes);

    final params = ShareParams(
      text:
          'Emballage bon van €${AmountFormatter.amountToString(_receipt!.amountInCents)} die je kunt inleveren bij ${_store!.name}. Verstuurd vanaf de Statiescan app.',
      files: [XFile(tempFile.path)],
    );

    final result = await SharePlus.instance.share(params);

    if (result.status == ShareResultStatus.success && mounted) {
      SnackbarCreator.show(
        context,
        status: SnackbarStatus.info,
        duration: Duration(seconds: 5),
        message: "Vergeet de bon niet te verwijderen na het delen.",
      );
    }
  }

  void _deleteReceipt() async {
    if (_receipt == null) return;

    await (_database.delete(_database.receipts)
      ..where((receipt) => receipt.id.equals(_receipt!.id))).go();

    if (!mounted) return;

    SnackbarCreator.show(
      context,
      status: SnackbarStatus.success,
      duration: Duration(seconds: 2),
      message: "De bon is succesvol verwijderd.",
    );

    context.go("/receipts");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreenScaffold(
      showAddButton: false,
      appBar: AppBar(title: const Text("Bon weergeven")),
      floatingActionButton: GestureDetector(
        onLongPress: _deleteReceipt,
        child: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
          onPressed:
              () => SnackbarCreator.show(
                context,
                status: SnackbarStatus.info,
                message: "Houd ingedrukt om te verwijderen.",
              ),
          child: const Icon(Icons.delete),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child:
              _receipt == null || _store == null
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BarcodeDisplay(
                        barcode: _receipt!.code,
                        height: 150,
                        width: 300,
                      ),
                      ReceiptInformationCard(
                        receipt: _receipt!,
                        store: _store!,
                      ),
                      ActionsRow(onShareButtonPress: _handleShareButton),
                    ],
                  ),
        ),
      ),
    );
  }
}
