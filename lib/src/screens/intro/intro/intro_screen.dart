import 'package:flutter/material.dart';
import 'intro_carousel.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: IntroCarousel(),
    );
  }
}
