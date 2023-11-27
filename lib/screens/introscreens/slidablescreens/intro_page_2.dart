import 'package:fitnessapplication/widgets/slidablescreenWidget.dart';
import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SlidableScreen(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      title: 'Step Tracker',
      subTitle: 'Stay Active Every Day',
      description:
          'FitGen Step Tracker allows you to monitor your daily steps and stay motivated to move more.',
      animation: 'assets/images/Animation - 1698680218934.json',
    );
  }
}
