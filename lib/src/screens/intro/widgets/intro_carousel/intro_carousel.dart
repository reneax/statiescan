import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:statiescan/src/repositories/settings/app_settings.dart';
import 'package:statiescan/src/screens/intro/intro_data.dart';
import 'package:statiescan/src/screens/intro/widgets/intro_carousel/widgets/carousel_display.dart';
import 'package:statiescan/src/screens/intro/widgets/intro_carousel/widgets/carousel_footer.dart';
import 'package:statiescan/src/services/notification_service.dart';

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

  bool _hasNextPage() => _currentIndex < introSlidesData.length - 1;

  void _setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _handleNextButton() {
    if (_hasNextPage()) {
      _goToPage(_currentIndex + 1);
    } else {
      _exitIntro();
    }
  }

  void _exitIntro() async {
    AppSettings.isIntroShown.set(true);
    context.go("/receipts");

    final notificationService = context.read<NotificationService>();

    final isNotificationsAllowed =
        await notificationService.isNotificationsAllowed();

    if (!isNotificationsAllowed) {
      notificationService.requestPermission().then((isAllowed) async {
        AppSettings.notificationsEnabled.set(isAllowed ?? false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        CarouselDisplay(
          pageController: _pageController,
          introSlidesData: introSlidesData,
          currentIndex: _currentIndex,
          setCurrentIndex: _setCurrentIndex,
        ),
        CarouselFooter(
          hasNextPage: _hasNextPage(),
          handleNextButton: _handleNextButton,
          introSlidesAmount: introSlidesData.length,
          currentSlideIndex: _currentIndex,
        ),
      ],
    );
  }
}
