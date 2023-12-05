import 'package:fitnessapplication/screens/workout/workoutcategory.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartWorkoutContainer extends StatelessWidget {
  const StartWorkoutContainer({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: screenHeight * 0.3,
            width: screenWidth * 0.92,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 151, 109, 233),
                  Color.fromARGB(255, 225, 209, 254),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 15, right: 8),
                  child: Text(
                    'START NOW FOR A',
                    style: GoogleFonts.openSans(color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize:screenHeight * .025,
                ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 8),
                  child: Text(
                    'BETTER TOMORROW',
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: screenHeight * .025,
                ),
                  ),
                ),
                SizedBox(height: screenHeight * .02),
                Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * .05,
                  ),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(6),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const CategoryScrn(),
                      ));
                    },
                    child: Text(
                      'START WORKOUT',
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w800,
                          fontSize: screenHeight * .017,
                          color: const Color.fromARGB(255, 153, 110, 226)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: screenWidth * .2,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/pexels-rdne-stock-project-8401873__1_-removebg-preview.png',
                  width: screenWidth * 0.99,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
