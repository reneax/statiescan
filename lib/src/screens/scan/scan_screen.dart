import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
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

    if (barcode.rawValue == null) {
      return;
    }

    int? amountInCents;

    if (capture.image != null) {
      setState(() {
        _isProcessing = true;
      });

      amountInCents =
          await AmountDetectorHelper(imageBytes: capture.image!).find();
    }

    if (!mounted) return;

    if (AppSettings.vibrationEnabled.get()) {
      Vibration.vibrate(duration: 100);
    }

    context.pushReplacementNamed(
      'createReceipt',
      queryParameters: {
        'barcode': barcode.rawValue!,
        'amount': amountInCents.toString(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Bon scannen")),
      body: Stack(
        children: [
          MobileScanner(
            controller: MobileScannerController(
              formats: [BarcodeFormat.ean13],
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
