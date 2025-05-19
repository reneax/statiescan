import 'package:flutter/material.dart';

class ScanLine extends StatelessWidget {
  final Animation<double> animation;
  final Rect scanBox;

  const ScanLine({super.key, required this.animation, required this.scanBox});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) {
        final dy = scanBox.top + animation.value * scanBox.height;
        return Positioned(
          left: scanBox.left,
          top: dy,
          child: Container(width: scanBox.width, height: 2, color: Colors.red),
        );
      },
    );
  }
}
