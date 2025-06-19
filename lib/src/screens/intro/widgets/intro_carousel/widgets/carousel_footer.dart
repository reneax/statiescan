import 'package:flutter/material.dart';
import 'package:statiescan/src/l10n/app_localizations.dart';
import 'package:statiescan/src/screens/intro/widgets/intro_dot_indicator.dart';

class CarouselFooter extends StatelessWidget {
  final bool hasNextPage;
  final VoidCallback handleNextButton;
  final int introSlidesAmount;
  final int currentSlideIndex;

  const CarouselFooter({
    super.key,
    required this.hasNextPage,
    required this.handleNextButton,
    required this.introSlidesAmount,
    required this.currentSlideIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          IntroDotIndicator(
            length: introSlidesAmount,
            currentIndex: currentSlideIndex,
          ),
          SizedBox(
            width: 200.0,
            height: 50.0,
            child: ElevatedButton(
              onPressed: handleNextButton,
              child: Text(
                hasNextPage
                    ? AppLocalizations.of(context)!.nextButton
                    : AppLocalizations.of(context)!.continueButton,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
