import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class ReceiptBarcode extends StatelessWidget {
  final String code;
  final BarcodeType type;

  const ReceiptBarcode({super.key, required this.code, required this.type});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BarcodeWidget(
      barcode: Barcode.fromType(type),
      data: code,
      width: 80,
      height: 40,
      drawText: false,
      color: isDark ? Colors.white : Colors.black,
    );
  }
}
