import 'package:fitnessapplication/screens/homescreen/homescreen.dart';
import 'package:fitnessapplication/screens/history/historyscreen.dart';
import 'package:fitnessapplication/screens/profile/profile.dart';
import 'package:fitnessapplication/screens/workout/workoutcategory.dart';
import 'package:flutter/material.dart';

void onTabChange(int index, int selectedIndex, BuildContext context) {
  // Handle navigation here based on the selected tab index.
  if (index != selectedIndex && index == 0) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  } else if (index != selectedIndex && index == 1) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const CategoryScrn(),
      ),
    );
  } else if (index != selectedIndex && index == 2) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HistoryScrn(),
      ),
    );
  } else if (index != selectedIndex && index == 3) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      ),
    );
  }
}
