import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BmiContainer extends StatefulWidget {
  const BmiContainer({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.bmiOfUserForDisplay,
    required this.height,
    required this.weight,
  });

  final double screenHeight;
  final double screenWidth;
  final double bmiOfUserForDisplay;
  final double height;
  final double weight;

  @override
  State<BmiContainer> createState() => _BmiContainerState();
}

class _BmiContainerState extends State<BmiContainer> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double userIdealWeight = getIdealWeight(
        widget.bmiOfUserForDisplay, widget.height, widget.weight);
    double minIdealWeight = userIdealWeight - 2;
    double maxIdealWeight = userIdealWeight + 2;
    return Container(
      // height: widget.screenHeight * 0.36,
      width: widget.screenWidth * 0.92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(colors: [
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 166, 127, 234)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(4.0, 4.0),
            blurRadius: 15,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(-4.0, -4.0),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: widget.screenHeight * .02),
            Center(
                child: Text('YOUR BMI STATUS',
                    style: GoogleFonts.poppins(
                        fontSize: widget.screenHeight * .027,
                        fontWeight: FontWeight.w700,
                        color: Colors.black))),
            SizedBox(height: widget.screenHeight * .03),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: Container(
                        height: widget.screenHeight * .22,
                        width: widget.screenHeight * .22,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/violet background.jpg')),
                            borderRadius: BorderRadius.circular(150),
                            color: Colors.teal),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('BMI',
                                  style: GoogleFonts.poppins(
                                      fontSize: widget.screenHeight * .035,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white)),
                              Text(
                                  widget.bmiOfUserForDisplay.toStringAsFixed(1),
                                  style: GoogleFonts.poppins(
                                      fontSize: widget.screenHeight * .04,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white)),
                              Text(
                                getBMIStatus(widget.bmiOfUserForDisplay),
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * .055,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      getBMIColor(widget.bmiOfUserForDisplay),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: widget.screenWidth * .02),
                Column(
                  children: [SizedBox(height:widget.screenWidth * .08),
                    SizedBox(
                      height: widget.screenWidth * .35,
                      width: widget.screenWidth * .35,
                      child: Image.asset(
                          'assets/images/fitgenlogo.png'),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: widget.screenWidth * .03),
            Column(
              children: [
                Text(
                  'IDEAL WEIGHT IS',
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w800,
                    fontSize: widget.screenHeight * .025,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${minIdealWeight.toStringAsFixed(0)}Kg TO ${maxIdealWeight.toStringAsFixed(0)}Kg',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w900,
                        fontSize: widget.screenHeight * .024,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: widget.screenHeight * .03,
            ),
          ],
        ),
      ),
    );
  }
}

//functions

String getBMIStatus(double bmi) {
  if (bmi < 18.5) {
    return 'Underweight';
  } else if (bmi >= 18.5 && bmi < 24.9) {
    return 'Normal';
  } else if (bmi >= 25 && bmi < 29.9) {
    return 'Overweight';
  } else if (bmi >= 30 && bmi < 34.9) {
    return 'Obese Class 1';
  } else {
    return 'Obese Class 2';
  }
}

Color getBMIColor(double bmi) {
  if (bmi < 18.5) {
    return Colors.blue;
  } else if (bmi >= 18.5 && bmi < 24.9) {
    return Colors.green;
  } else if (bmi >= 25 && bmi < 29.9) {
    return Colors.orange;
  } else if (bmi >= 30 && bmi < 34.9) {
    return Colors.yellow;
  } else {
    return Colors.red;
  }
}

double getIdealWeight(double bmi, double height, double weight) {
  return ((height - 100) * 0.9);
}

double calculateBmi(
    {required double heightForCalculatingBmi,
    required double weightForCalculatingBmi}) {
  double heightInMetre = heightForCalculatingBmi / 100.0;
  double bmi0fUser = weightForCalculatingBmi / (heightInMetre * heightInMetre);
  return bmi0fUser;
}
