import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HoverAnimatedTitle extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final bool isHovering;

  const HoverAnimatedTitle({
    super.key,
    required this.title,
    required this.style,
    required this.isHovering,
  });

  @override
  Widget build(BuildContext context) {
    if (isHovering) {
      return AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            title,
            textStyle: style,
            speed: const Duration(milliseconds: 150),
          ),
        ],
        isRepeatingAnimation: false,
        displayFullTextOnTap: true,
      );
    } else {
      return Text(title, style: style);
    }
  }
}