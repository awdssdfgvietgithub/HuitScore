import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/messi_introduction.png",
      fit: BoxFit.cover,
    );
  }
}
