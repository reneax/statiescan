import 'package:flutter/material.dart';
import 'package:statiescan/src/screens/scan/widgets/scan_crosshair/widgets/scan_line.dart';
import 'package:statiescan/src/screens/scan/widgets/scan_crosshair/widgets/scan_overlay_painter.dart';

class ScanCrosshair extends StatefulWidget {
  const ScanCrosshair({super.key});

  @override
  State<ScanCrosshair> createState() => _ScanCrosshairState();
}

class _ScanCrosshairState extends State<ScanCrosshair>
    with SingleTickerProviderStateMixin {
  static const double _scanBoxWidth = 250.0;
  static const double _scanBoxHeight = 150.0;
  static const Duration _scanDuration = Duration(seconds: 1);

  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _scanDuration)
      ..repeat(reverse: true);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final centerX = (constraints.maxWidth - _scanBoxWidth) / 2;
        final centerY = (constraints.maxHeight - _scanBoxHeight) / 2;
        final scanBox = Rect.fromLTWH(
          centerX,
          centerY,
          _scanBoxWidth,
          _scanBoxHeight,
        );

        return Stack(
          children: [
            CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: ScanOverlayPainter(scanBox: scanBox),
            ),
            ScanLine(animation: _animation, scanBox: scanBox),
          ],
        );
      },
    );
  }
}
