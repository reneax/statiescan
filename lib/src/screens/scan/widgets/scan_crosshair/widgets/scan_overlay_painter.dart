import 'package:flutter/material.dart';

class ScanOverlayPainter extends CustomPainter {
  final Rect scanBox;

  ScanOverlayPainter({required this.scanBox});

  @override
  void paint(Canvas canvas, Size size) {
    final fullRect = Offset.zero & size;

    final overlayPaint =
        Paint()
          ..color = Colors.black.withAlpha(128)
          ..style = PaintingStyle.fill;

    final borderPaint =
        Paint()
          ..color = Colors.green
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke;

    final overlayPath = Path.combine(
      PathOperation.difference,
      Path()..addRect(fullRect),
      Path()..addRect(scanBox),
    );

    canvas.drawPath(overlayPath, overlayPaint);
    canvas.drawRect(scanBox, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
