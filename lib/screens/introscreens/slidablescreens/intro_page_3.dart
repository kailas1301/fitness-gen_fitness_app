import 'package:fitnessapplication/widgets/slidablescreenWidget.dart';
import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: SlidableScreen(
        screenWidth: screenWidth,
        // screenHeight: screenHeight,
        title: ' Water Tracker',
        subTitle: ' Hydrate for Optimal Performance',
        description:
            'Never forget to stay hydrated FitGens Water Tracker helps you keep track of your daily water intake for better overall health.',
        animation: 'assets/images/wateranimation.json',
      ),
    );
  }
}
