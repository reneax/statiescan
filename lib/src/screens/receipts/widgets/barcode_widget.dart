import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class ReceiptBarcode extends StatelessWidget {
  final String code;

  const ReceiptBarcode({super.key, required this.code});

  String formatToEan13(String input) {
    final digits = input.replaceAll(RegExp(r'\D'), '');
    return digits.padLeft(13, '0').substring(0, 13);
  }

  @override
  Widget build(BuildContext context) {
    final formattedCode = formatToEan13(code);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BarcodeWidget(
      barcode: Barcode.ean13(),
      data: formattedCode,
      width: 80,
      height: 40,
      drawText: false,
      color: isDark ? Colors.white : Colors.black,
    );
  }
}
