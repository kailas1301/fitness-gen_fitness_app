import 'package:fitnessapplication/widgets/slidablescreenWidget.dart';
import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SlidableScreen(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      title: 'Workout Tracker',
      subTitle: 'Achieve Your Fitness Goals',
      description:
          'Track your workouts with FitGen Workout Tracker. Personalize your fitness routine and see results like never before.',
      animation: 'assets/images/Animation - 1698680289566.json',
    );
  }
}
