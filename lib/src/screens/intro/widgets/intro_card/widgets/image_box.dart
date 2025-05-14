import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String imagePath;

  const ImageBox({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
      ),
    );
  }
}
