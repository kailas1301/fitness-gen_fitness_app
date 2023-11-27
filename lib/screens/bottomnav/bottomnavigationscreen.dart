import 'package:fitnessapplication/screens/homescreen/homescreen.dart';
import 'package:fitnessapplication/screens/history/Historyscreen.dart';
import 'package:fitnessapplication/screens/profile/profile.dart';
import 'package:fitnessapplication/screens/workout/workoutcategory.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavScrn extends StatefulWidget {
  const BottomNavScrn({super.key});
  @override
  State<BottomNavScrn> createState() => _BottomNavScrnState();
}

class _BottomNavScrnState extends State<BottomNavScrn> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoryScrn(),
    const HistoryScrn(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GNav(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          tabBackgroundColor: const Color.fromARGB(255, 238, 229, 243),
          activeColor: Colors.deepPurple,
          gap: 6,
          iconSize: 18,
          textSize: 10,
          selectedIndex: _selectedIndex,
          onTabChange: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: 'Home',
            ),
            GButton(
              icon: Icons.directions_walk_outlined,
              text: 'Exercises',
            ),
            GButton(
              icon: Icons.history,
              text: 'History',
            ),
            GButton(
              icon: Icons.person_outlined,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
