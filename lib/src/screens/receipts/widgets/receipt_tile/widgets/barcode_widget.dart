import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class ReceiptBarcode extends StatelessWidget {
  final String code;

  const ReceiptBarcode({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BarcodeWidget(
      barcode: Barcode.code128(),
      data: code,
      width: 80,
      height: 40,
      drawText: false,
      color: isDark ? Colors.white : Colors.black,
    );
  }
}
