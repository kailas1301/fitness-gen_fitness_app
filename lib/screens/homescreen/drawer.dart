import 'dart:io';
import 'package:fitnessapplication/database/userinformation/userdata.dart';
import 'package:fitnessapplication/screens/drawerscreens/aboutapp/about_app.dart';
import 'package:fitnessapplication/screens/drawerscreens/caloriecalculator/calorie_calculator.dart';
import 'package:fitnessapplication/screens/history/historyscreen.dart';
import 'package:fitnessapplication/screens/drawerscreens/privacypolicy/privacy_policy.dart';
import 'package:fitnessapplication/screens/profile/profile.dart';
import 'package:fitnessapplication/screens/drawerscreens/reminder_screens/reminders.dart';
import 'package:fitnessapplication/widgets/customtilefordrawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerClass extends StatefulWidget {
  const DrawerClass({
    super.key,
    required this.userdata,
    required this.userImageFrmHive,
  });

  final User? userdata;
  final String? userImageFrmHive;

  @override
  State<DrawerClass> createState() => _DrawerClassState();
}

class _DrawerClassState extends State<DrawerClass> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 138, 95, 219),
            Color.fromARGB(255, 255, 255, 255)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListView(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Hero(
                  tag: 'userImageHero',
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 90,
                      backgroundColor: const Color.fromARGB(255, 11, 1, 1),
                      child: widget.userImageFrmHive != null
                          ? ClipOval(
                              child: Image.file(
                                File(widget.userImageFrmHive!),
                                height: 180,
                                width: 180,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Center(
                              child: Icon(Icons.add_a_photo,
                                  size: 40, color: Colors.white),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.userdata?.fullName.toUpperCase() ?? '',
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w700,
                    fontSize: screenHeight * .025,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          CustomListTile(
            icon: Icons.history,
            title: 'History',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HistoryScrn(),
                ),
              );
            },
          ),
          CustomListTile(
            icon: Icons.person,
            title: 'Profile',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
          CustomListTile(
            icon: Icons.timer,
            title: 'Reminders',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ReminderScreen(),
                ),
              );
            },
          ),
          CustomListTile(
            icon: Icons.health_and_safety,
            title: 'Calorie Calculator',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CalorieCalculatorScreen(),
                ),
              );
            },
          ),
          CustomListTile(
            icon: Icons.info_outline_rounded,
            title: 'About App',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AboutApp(),
                ),
              );
            },
          ),
          CustomListTile(
            icon: Icons.privacy_tip_rounded,
            title: 'Privacy Policy',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

