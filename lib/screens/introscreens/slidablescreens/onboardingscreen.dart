import 'package:fitnessapplication/screens/introscreens/personalinformations.dart';
import 'package:fitnessapplication/screens/introscreens/slidablescreens/intro_page_1.dart';
import 'package:fitnessapplication/screens/introscreens/slidablescreens/intro_page_2.dart';
import 'package:fitnessapplication/screens/introscreens/slidablescreens/intro_page_3.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageViewController = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageViewController,
            onPageChanged: (index) {
              setState(() {
                onLastPage = index == 2;
              });
            },
            children: const [IntroPage1(), IntroPage2(), IntroPage3()],
          ),
          Container(
            alignment: const Alignment(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    onTap: () {
                      pageViewController.jumpToPage(2);
                    },
                    child: Text('Skip',
                        style: GoogleFonts.openSans(
                            fontSize: screenWidth * .04,
                            fontWeight: FontWeight.w700))),
                SmoothPageIndicator(controller: pageViewController, count: 3),
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PersonalInfo(),
                              ));
                        },
                        child: Text('Done',
                            style: GoogleFonts.openSans(
                                fontSize: screenWidth * .04,
                                fontWeight: FontWeight.w700)))
                    : GestureDetector(
                        onTap: () {
                          pageViewController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text('Next',
                            style: GoogleFonts.openSans(
                                fontSize: screenWidth * .04,
                                fontWeight: FontWeight.w700)))
              ],
            ),
          )
        ],
      ),
    );
  }
}
