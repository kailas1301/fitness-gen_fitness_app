import 'package:fitnessapplication/screens/introscreens/slidablescreens/onboardingscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Container(
                // decoration: BoxDecoration(
                //   color: const Color.fromARGB(255, 255, 255, 255),
                //   borderRadius: BorderRadius.circular(screenWidth * 0.03),
                //   border: Border.all(
                //     width: 1,
                //     color: const Color(0xFFDFDDDD),
                //   ),
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.grey.shade400,
                //       offset: const Offset(4.0, 4.0),
                //       blurRadius: 15,
                //       spreadRadius: 1,
                //     ),
                //     BoxShadow(
                //       color: Colors.grey.shade400,
                //       offset: const Offset(-4.0, -4.0),
                //       blurRadius: 15,
                //       spreadRadius: 1,
                //     )
                //   ],
                // ),
                height: screenHeight * 0.91,
                width: screenWidth * 1,
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.1),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.05, right: screenWidth * 0.05),
                      child: Text(
                        'Welcome to FIT-GEN',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.05, right: screenWidth * 0.05),
                      child: Text(
                        'An app that will help you analyze and track your fitness activities in your daily life.  Come join the FitGen family!',
                        style: GoogleFonts.poppins(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 121, 120, 120),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: Lottie.asset(
                            'assets/images/Animation - 1698679203908.json'),
                      ),
                    ),
                    SizedBox(height: screenHeight * .15),
                    // Adjusted height
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                              Size(screenWidth * .7, screenHeight * .06)),
                          elevation: MaterialStateProperty.all(25.0),
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 103, 39, 176),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const OnBoardingScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Get Started',
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * .07,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
