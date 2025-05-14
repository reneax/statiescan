import 'package:flutter/material.dart';
import 'package:statiescan/src/screens/intro/widgets/intro_card/widgets/card_text.dart';
import 'package:statiescan/src/screens/intro/widgets/intro_card/widgets/image_box.dart';

class IntroCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const IntroCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CardText(title: title, description: description),
            ImageBox(imagePath: image),
          ],
        ),
      ),
    );
  }
}
