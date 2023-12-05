// ignore_for_file: use_build_context_synchronously

import 'package:fitnessapplication/database/userinformation/dbfunctions.dart';
import 'package:fitnessapplication/widgets/bottomnav/bottomnavigationscreen.dart';
import 'package:fitnessapplication/screens/introscreens/welcomescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    bool isDataPresent = isUserDataPresent();
    showSplash(context, isDataPresent);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(
        children: [
          SizedBox(
            height: screenHeight * .3,
            child: Lottie.asset(
              'assets/images/SZGn8KGt9M (1).json',
              width: screenWidth * 0.8,
            ),
          ),
          Text(
            'FIT-GEN',
            style: GoogleFonts.kalam(
              fontSize: screenWidth * 0.10,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Transforming Generations',
            style: GoogleFonts.dancingScript(
              fontSize: screenWidth * 0.07,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
            ),
          ])));
  }
}

void showSplash(BuildContext context, bool value) async {
  await Future.delayed(const Duration(seconds: 4));

  if (value == false) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const BottomNavScrn(),
    ));
  } else {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const WelcomeScreen(),
    ));
  }
}
