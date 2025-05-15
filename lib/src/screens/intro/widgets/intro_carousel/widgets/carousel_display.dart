import 'package:flutter/material.dart';
import 'package:statiescan/src/screens/intro/widgets/intro_slide/intro_slide.dart';

class CarouselDisplay extends StatefulWidget {
  final PageController pageController;
  final List<Map<String, dynamic>> introSlidesData;
  final void Function(int index) setCurrentIndex;
  final int currentIndex;

  const CarouselDisplay({
    super.key,
    required this.pageController,
    required this.introSlidesData,
    required this.setCurrentIndex,
    required this.currentIndex,
  });

  @override
  State<CarouselDisplay> createState() => _CarouselDisplayState();
}

class _CarouselDisplayState extends State<CarouselDisplay> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: widget.pageController,
        itemCount: widget.introSlidesData.length,
        itemBuilder: (context, index) {
          final slide = widget.introSlidesData[index];
          return IntroSlide(
            title: slide['title'],
            description: slide['description'],
            image: slide['image'],
          );
        },
        onPageChanged: (index) {
          widget.setCurrentIndex(index);
        },
      ),
    );
  }
}
