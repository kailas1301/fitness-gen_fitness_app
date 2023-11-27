import 'package:fitnessapplication/database/watertracker/watertrackerfunctions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WarterTrackerContainer extends StatefulWidget {
  const WarterTrackerContainer({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.limitOfGlass,
  });

  final double screenHeight;
  final double screenWidth;
  final int limitOfGlass;

  @override
  State<WarterTrackerContainer> createState() => _WarterTrackerContainerState();
}

class _WarterTrackerContainerState extends State<WarterTrackerContainer> {
  int noOfGlasses = 0;

  @override
  void initState() {
    updateWaterIntakeForToday();
    super.initState();
  }

  Future<void> updateWaterIntakeForToday() async {
    final today = DateTime.now();
    final waterIntake = await getWaterIntakeForDate(today);
    setState(() {
      noOfGlasses = waterIntake;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidth * 0.92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(colors: [
          Color.fromARGB(255, 187, 158, 237),
          Color.fromARGB(255, 255, 255, 255)
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
      child: Padding(
        padding: EdgeInsets.only(
            top: widget.screenHeight * .02, bottom: widget.screenHeight * .025),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'TRACK YOUR DAILY ',
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w800,
                  fontSize: widget.screenHeight * .025,
                ),
              ),
              Text(
                ' WATER CONSUMPTION',
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w800,
                    fontSize: widget.screenHeight * .025),
              ),
              SizedBox(height: widget.screenHeight * .02),
              Padding(
                padding: EdgeInsets.only(
                    left: widget.screenHeight * .02,
                    bottom: widget.screenHeight * .01),
                child: Row(
                  children: [
                    CircularPercentIndicator(
                      animation: true,
                      animationDuration: 1000,
                      radius: widget.screenWidth * 0.18,
                      lineWidth: 17,
                      percent: widget.limitOfGlass > 0
                          ? noOfGlasses / widget.limitOfGlass
                          : 0.0, // Check for division by zero
                      progressColor: Colors.deepPurple,
                      backgroundColor: const Color.fromARGB(255, 236, 222, 249),
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Icon(
                        Icons.water_drop_outlined,
                        color: Colors.deepPurple,
                        size: widget.screenWidth * 0.1,
                      ),
                    ),
                    SizedBox(width: widget.screenWidth * .03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.deepPurple,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.deepPurple.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.all(widget.screenWidth * .03),
                                child: Text(
                                  noOfGlasses < widget.limitOfGlass
                                      ? "Add a glass"
                                      : "Goal Completed",
                                  style: GoogleFonts.openSans(
                                    fontSize: widget.screenWidth * .03,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (noOfGlasses < widget.limitOfGlass) {
                                  setState(() {
                                    addGlassOfWater(noOfGlasses);
                                  });
                                  updateWaterIntakeForToday();
                                } else {}
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 118, 66, 207),
                                elevation: 4,
                                shape: const CircleBorder(),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.all(widget.screenHeight * .01),
                                child: Center(
                                    child: Icon(
                                  noOfGlasses < widget.limitOfGlass
                                      ? Icons.add
                                      : Icons.check,
                                  size: widget.screenWidth * .05,
                                  color: Colors.white,
                                )),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: widget.screenHeight * .02),
                        Row(
                          children: [
                            Text(noOfGlasses.toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: widget.screenWidth * .09,
                                    fontWeight: FontWeight.w700)),
                            SizedBox(width: widget.screenWidth * .02),
                            Text('out of',
                                style: GoogleFonts.poppins(
                                    fontSize: widget.screenWidth * .043,
                                    fontWeight: FontWeight.w800)),
                          ],
                        ),
                        Row(
                          children: [
                            Text(widget.limitOfGlass.toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: widget.screenWidth * .09,
                                    fontWeight: FontWeight.w700)),
                            SizedBox(width: widget.screenWidth * .02),
                            Text('Completed',
                                style: GoogleFonts.poppins(
                                  fontSize: widget.screenWidth * .043,
                                  fontWeight: FontWeight.w800,
                                )),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
