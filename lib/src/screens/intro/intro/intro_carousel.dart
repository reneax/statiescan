import 'package:flutter/material.dart';
import 'intro_slide.dart';

class IntroCarousel extends StatefulWidget {
  const IntroCarousel({super.key});

  @override
  State<IntroCarousel> createState() => _IntroCarouselState();
}

class _IntroCarouselState extends State<IntroCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _slides = [
    {
      'title': 'Scannen met app',
      'description': 'Scan bonnetjes eenvoudig met je telefoon.'
    },
    {
      'title': 'Bonnetjes terugvinden',
      'description': 'Vind je opgeslagen bonnetjes snel terug.'
    },
    {
      'title': 'Notificaties wanneer bonnetje verloopt',
      'description': 'Krijg meldingen voordat je bon vervalt.'
    },
    {
      'title': 'Delen met mensen',
      'description': 'Deel je bonnen gemakkelijk met anderen.'
    },
  ];

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToPrevious() {
    if (_currentIndex > 0) {
      _goToPage(_currentIndex - 1);
    }
  }

  void _goToNext() {
    if (_currentIndex < _slides.length - 1) {
      _goToPage(_currentIndex + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
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
                    itemCount: _slides.length,
                    itemBuilder: (context, index) {
                      final slide = _slides[index];
                      return IntroSlide(
                        title: slide['title']!,
                        description: slide['description']!,
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
                  _currentIndex == _slides.length - 1 ? null : _goToNext,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_slides.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentIndex == index ? 12 : 8,
                height: _currentIndex == index ? 12 : 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey[400],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
