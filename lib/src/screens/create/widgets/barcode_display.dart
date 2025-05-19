import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class BarcodeDisplay extends StatelessWidget {
  final String barcode;

  const BarcodeDisplay({super.key, required this.barcode});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: const Color(0xFFF2F3FA),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: BarcodeWidget(
            barcode: Barcode.ean13(),
            style: TextStyle(color: Colors.black),
            color: Colors.black,
            data: barcode,
            height: 100,
            width: 200,
          ),
        ),
      ),
    );
  }
}
