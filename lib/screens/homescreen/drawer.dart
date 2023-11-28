import 'dart:io';
import 'package:fitnessapplication/database/userinformation/userdata.dart';
import 'package:fitnessapplication/screens/drawerscreens/aboutapp/about_app.dart';
import 'package:fitnessapplication/screens/drawerscreens/caloriecalculator/calorie_calculator.dart';
import 'package:fitnessapplication/screens/drawerscreens/history/Historyscreen.dart';
import 'package:fitnessapplication/screens/drawerscreens/privacypolicy/privacy_policy.dart';
import 'package:fitnessapplication/screens/drawerscreens/profile/profile.dart';
import 'package:fitnessapplication/screens/drawerscreens/reminder_screens/reminders.dart';
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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [ Color.fromARGB(255, 138, 95, 219),
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
                  style: GoogleFonts.roboto(
                      fontSize: 25, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Section with history icon
          ListTile(
            leading: const Icon(Icons.history, size: 30),
            title: const Text('History'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HistoryScrn(),
                ),
              );
            },
          ),
          // Section with profile icon
          ListTile(
            leading: const Icon(Icons.person, size: 30),
            title: const Text('Profile'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.timer, size: 30),
            title: const Text('Reminders'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ReminderScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.health_and_safety),
            title: const Text('Calorie Calculator'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CalorieCalculatorScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('About App'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AboutApp(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_rounded),
            title: const Text('Privacy Policy'),
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
