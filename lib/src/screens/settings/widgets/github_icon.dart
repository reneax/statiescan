import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GithubIcon extends StatefulWidget {
  const GithubIcon({super.key});

  @override
  State<GithubIcon> createState() => _GithubIconState();
}

class _GithubIconState extends State<GithubIcon> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    String assetPath =
        isDark
            ? 'assets/images/github-white.svg'
            : 'assets/images/github-dark.svg';

    return SizedBox(
      width: 25,
      height: 25,
      child: SvgPicture.asset(
        assetPath,
        width: 25,
        height: 25,
        fit: BoxFit.contain,
      ),
    );
  }
}
