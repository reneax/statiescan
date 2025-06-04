import 'package:flutter/material.dart';
import 'package:statiescan/src/screens/intro/widgets/intro_carousel/intro_carousel.dart';
import 'package:statiescan/src/widgets/default_screen_scaffold.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: IntroCarousel());
  }
}
