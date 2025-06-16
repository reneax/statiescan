import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class BarcodeDisplay extends StatelessWidget {
  final double height, width;
  final String barcode;
  final BarcodeType type;

  const BarcodeDisplay({
    super.key,
    required this.barcode,
    required this.type,
    this.height = 100,
    this.width = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: const Color(0xFFF2F3FA),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: BarcodeWidget(
            barcode: Barcode.fromType(type),
            style: TextStyle(color: Colors.black),
            color: Colors.black,
            data: barcode,
            height: height,
            width: width,
          ),
        ),
      ),
    );
  }
}
