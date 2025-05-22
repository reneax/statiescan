import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:statiescan/src/utils/amount_formatter.dart';

class AmountDetectorHelper {
  static final RegExp _amountRegex = RegExp(
    r'\b\d{1,3}(?:[.,]?\d{3})*[.,]\d{2}\b',
  );
  static final RegExp _formatLineRegex = RegExp(r'\s+');

  final Uint8List imageBytes;
  final Size imageSize;

  const AmountDetectorHelper({
    required this.imageBytes,
    required this.imageSize,
  });

  Future<InputImage> _createInputImageFromBytes() async {
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/temp.jpg');

    await tempFile.writeAsBytes(imageBytes);

    return InputImage.fromFilePath(tempFile.path);
  }

  void _removeTempImage() async {
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/temp.jpg');

    tempFile.deleteSync();
  }

  Future<int?> find() async {
    final inputImage = await _createInputImageFromBytes();
    final textRecognizer = TextRecognizer();

    try {
      final recognizedText = await textRecognizer.processImage(inputImage);

      for (final block in recognizedText.blocks) {
        for (final line in block.lines) {
          final formattedLine = line.text.replaceAll(_formatLineRegex, "");

          for (final match in _amountRegex.allMatches(formattedLine)) {
            final raw = match.group(0);

            if (raw == null) continue;

            return AmountFormatter.stringToAmount(raw);
          }
        }
      }
    } finally {
      textRecognizer.close();
      _removeTempImage();
    }

    return null;
  }
}
