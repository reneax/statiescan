import 'package:flutter/material.dart';
import 'package:statiescan/src/screens/intro/widgets/intro_slide/widgets/slide_text.dart';
import 'package:statiescan/src/screens/intro/widgets/intro_slide/widgets/image_box.dart';

class IntroSlide extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const IntroSlide({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageBox(imagePath: image),
            SlideText(title: title, description: description),
          ],
        ),
      ),
    );
  }
}
