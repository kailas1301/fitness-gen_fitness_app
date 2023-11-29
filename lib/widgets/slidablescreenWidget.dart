import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SlidableScreen extends StatelessWidget {
  const SlidableScreen({
    super.key,
    required this.screenWidth,
    // required this.screenHeight,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.animation,
  });

  final double screenWidth;
  // final double screenHeight;
  final String title;
  final String subTitle;
  final String description;
  final String animation;

  @override
  Widget build(BuildContext context) {
   final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.all(screenWidth * .03),
      child: Container(
        color: Colors.white,
        child: Column(children: [
          SizedBox(height: screenHeight * .07),
          Text(
            title,
            style: GoogleFonts.openSans(
                fontSize: screenWidth * .05, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: screenHeight * .02),
          Text(
            subTitle,
            style: GoogleFonts.openSans(
                fontSize: screenWidth * .04, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: screenWidth * .9,
            child: Lottie.asset(animation),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * .03),
            child: Text(
              description,
              style: GoogleFonts.openSans(
                  fontSize: screenWidth * .04, fontWeight: FontWeight.w700),
            ),
          ),
        ]),
      ),
    );
  }
}
