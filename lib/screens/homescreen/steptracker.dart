import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pedometer/pedometer.dart';

class StepTrackerScrn extends StatefulWidget {
  const StepTrackerScrn({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  State<StepTrackerScrn> createState() => _StepTrackerScrnState();
}

class _StepTrackerScrnState extends State<StepTrackerScrn> {
  late Stream<StepCount> stepCountStream;
  String steps = '0';
  bool isPaused = false;
  double caloriesPerStep = 0.04;
  double calories = 0;

  @override
  void initState() {
    super.initState();
    initPedometer();
  }

  void initPedometer() {
    stepCountStream = Pedometer.stepCountStream;
    stepCountStream.listen(_onStepCount).onError(_onStepCountError);
  }

  void _onStepCount(StepCount event) {
    setState(() {
      if (!isPaused) {
        steps = event.steps.toString();
        calories = int.parse(steps) * caloriesPerStep;
      }
    });
  }

  void _onStepCountError(error) {
    setState(() {
      steps = 'Step Count not available';
    });
  }

  void _togglePause() {
    setState(() {
      isPaused = !isPaused;
      if (isPaused) {
        stepCountStream =
            const Stream.empty(); // Pause by using an empty stream
      } else {
        initPedometer(); // Resume by initializing the stream again
      }
    });
  }

  void _restart() {
    setState(() {
      steps = '0';
      initPedometer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.screenWidth * .92,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 187, 158, 237),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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
        child: Padding(
          padding: EdgeInsets.only(
            top: widget.screenHeight * .02,
            bottom: widget.screenHeight * .025,
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  'TRACK YOUR DAILY STEPS',
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w800,
                    fontSize: widget.screenHeight * .025,
                  ),
                ),
                SizedBox(height: widget.screenHeight * .02),
                Padding(
                  padding: EdgeInsets.only(bottom: widget.screenHeight * .01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Lottie.asset(
                          'assets/images/walking animation.json',
                          height: widget.screenHeight * .3,
                        ),
                      ),
                      SizedBox(height: widget.screenHeight * .02),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      steps,
                                      style: GoogleFonts.poppins(
                                        fontSize: widget.screenWidth * .1,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: widget.screenWidth * .02),
                                    Text(
                                      'STEPS',
                                      style: GoogleFonts.poppins(
                                        fontSize: widget.screenWidth * .043,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      calories.toStringAsFixed(
                                          2), // This ensures only two decimal points are shown
                                      style: GoogleFonts.poppins(
                                        fontSize: widget.screenWidth * .1,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(width: widget.screenWidth * .025),
                                    Text(
                                      'CALORIES',
                                      style: GoogleFonts.poppins(
                                        fontSize: widget.screenWidth * .043,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: _togglePause,
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    minimumSize: Size(widget.screenWidth * 0.2,
                                        50), // Set the width and height
                                  ),
                                  child: Text(
                                    isPaused ? 'Resume' : 'Pause',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                SizedBox(height: widget.screenWidth * 0.02),
                                ElevatedButton(
                                  onPressed: _restart,
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0), // Set the border radius
                                    ),
                                    minimumSize: Size(widget.screenWidth * 0.2,
                                        50), // Set the width and height
                                  ),
                                  child: const Text(
                                    'Restart',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
