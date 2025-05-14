import 'package:flutter/material.dart';
import 'package:statiescan/src/screens/intro/intro_data.dart';
import 'package:statiescan/src/screens/intro/widgets/continue_button.dart';
import 'package:statiescan/src/screens/intro/widgets/intro_card/intro_card.dart';
import 'package:statiescan/src/screens/intro/widgets/intro_dot_indicator.dart';

class IntroCarousel extends StatefulWidget {
  const IntroCarousel({super.key});

  @override
  State<IntroCarousel> createState() => _IntroCarouselState();
}

class _IntroCarouselState extends State<IntroCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToPrevious() {
    if (_currentIndex > 0) _goToPage(_currentIndex - 1);
  }

  void _goToNext() {
    if (_currentIndex < introSlidesData.length - 1) {
      _goToPage(_currentIndex + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 450,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: _currentIndex == 0 ? null : _goToPrevious,
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: introSlidesData.length,
                    itemBuilder: (context, index) {
                      final slide = introSlidesData[index];
                      return IntroCard(
                        title: slide['title'],
                        description: slide['description'],
                        image: slide['image'],
                      );
                    },
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed:
                      _currentIndex == introSlidesData.length - 1
                          ? null
                          : _goToNext,
                ),
              ],
            ),
          ),
          IntroDotIndicator(
            length: introSlidesData.length,
            currentIndex: _currentIndex,
          ),
          ContinueButton(
            shouldShow: _currentIndex == introSlidesData.length - 1,
          ),
        ],
      ),
    );
  }
}
