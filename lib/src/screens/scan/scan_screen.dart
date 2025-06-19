import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';
import 'package:statiescan/src/repositories/settings/app_settings.dart';
import 'package:statiescan/src/screens/scan/widgets/processing_text_overlay.dart';
import 'package:statiescan/src/screens/scan/widgets/scan_crosshair/scan_crosshair.dart';
import 'package:statiescan/src/utils/amount_detector.dart';
import 'package:vibration/vibration.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool _isProcessing = false;

  void _onBarcodeDetect(BarcodeCapture capture) async {
    Barcode barcode = capture.barcodes.first;
    String? barcodeValue = barcode.displayValue ?? barcode.rawValue;
    int barcodeType = barcode.format.rawValue;

    if (barcodeValue == null) return;

    int? amountInCents;
    final capturedImage = capture.image;

    if (capturedImage != null) {
      setState(() {
        _isProcessing = true;
      });

      amountInCents =
          await AmountDetectorHelper(imageBytes: capturedImage).find();
    }

    if (!mounted) return;

    if (AppSettings.vibrationEnabled.get()) {
      Vibration.vibrate(duration: 100);
    }

    context.pushReplacementNamed(
      'createReceipt',
      queryParameters: {
        'barcode': barcodeValue,
        'amount': amountInCents.toString(),
        'type': barcodeType.toString(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.scanReceiptTitle),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.noDuplicates,
              returnImage: AppSettings.automaticAmountDetection.get(),
            ),
            onDetect: (capture) => _onBarcodeDetect(capture),
          ),
          _isProcessing ? const ProcessingTextOverlay() : const ScanCrosshair(),
        ],
      ),
    );
  }
}
