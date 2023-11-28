import 'package:fitnessapplication/database/watertracker/watertrackerfunctions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fitnessapplication/database/workoutdb/workoutmodel.dart';
import 'package:fitnessapplication/screens/workout/functionsforworkout.dart';

class HistoryScrn extends StatefulWidget {
  const HistoryScrn({super.key});
  @override
  State<HistoryScrn> createState() => _HistoryScrnState();
}

class _HistoryScrnState extends State<HistoryScrn> {
  int pageindex = 2;
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  int waterIntakeForSelectedDate = 0;
  List<SetModel> listOfSetsForTheDay = [];
  String exerciseNameForSets = '';

  @override
  void initState() {
    super.initState();
    exerciseNameForSets;
    selectedDay = DateTime.now();
    fetchWaterIntakeData(selectedDay!);
    fetchSetdataForTheDay(selectedDay!);
    groupSetsByExercise();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * .05),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 12.5, left: 25.0, right: 25.0, bottom: 12.5),
                    child: TableCalendar(
                      formatAnimationCurve: Curves.decelerate,
                      availableGestures: AvailableGestures.all,
                      calendarFormat: calendarFormat,
                      focusedDay: focusedDay,
                      firstDay: DateTime(2000),
                      lastDay: DateTime.now(),
                      selectedDayPredicate: (day) {
                        return isSameDay(selectedDay, day);
                      },
                      onDaySelected: (selectedDate, focusedDay) {
                        setState(() {
                          selectedDay = selectedDate;
                        });
                        fetchWaterIntakeData(selectedDate);
                        fetchSetdataForTheDay(selectedDate);
                      },
                    ),
                  ),
                  Center(
                    child: Text(
                      "Selected Date: ${selectedDay?.day}-${selectedDay?.month}-${selectedDay?.year}",
                      style: GoogleFonts.roboto(
                        fontSize: screenHeight * .03,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: Container(
                            child: Lottie.asset(
                              'assets/images/wateranimations.json',
                              fit: BoxFit.fitWidth,
                              height: screenHeight * 0.45,
                              width: screenHeight * 1,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "Water Intake",
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "$waterIntakeForSelectedDate glasses",
                              style: GoogleFonts.openSans(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ), Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('WorkoutHistory',style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w700),),
                  ))
                ],
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                String exerciseKey =
                    groupSetsByExercise().keys.elementAt(index);
                List<SetModel> exerciseSets =
                    groupSetsByExercise()[exerciseKey]!;
                final exerciseName = exerciseSets.first.exerciseId;
                final exerciseKeyforGettingName =
                    exerciseSets.first.exercise.exerciseKey.toString();
                return FutureBuilder<String>(
                  future:
                      getExerciseName(exerciseKeyforGettingName, exerciseName),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final exerciseToDisplayName = snapshot.data;

                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: screenHeight * .015,
                              left: screenHeight * .03,
                              right: screenHeight * .03,
                              bottom: screenHeight * .015,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 234, 232, 237),
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 214, 208, 225),
                                    Color.fromARGB(255, 205, 188, 237),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: const Offset(2.0, 2.0),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: const Offset(-2.0, -2.0),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      exerciseToDisplayName
                                          .toString()
                                          .toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    // Display sets for the exercise
                                    for (var set in exerciseSets)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            ' Weight: ${set.weight} kg',
                                            style: GoogleFonts.poppins(
                                              fontSize: screenHeight * .0195,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'Reps: ${set.reps}',
                                            style: GoogleFonts.poppins(
                                              fontSize: screenHeight * .0195,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              },
              childCount: groupSetsByExercise().length,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchSetdataForTheDay(DateTime selectedDate) async {
    final setDataOfTheDay = await getSetDataForTheDay(selectedDate);
    setState(() {
      listOfSetsForTheDay = setDataOfTheDay;
    });
  }

  Future<void> fetchWaterIntakeData(DateTime selectedDate) async {
    try {
      final waterIntake = await getWaterIntakeForDate(selectedDate);
      setState(() {
        waterIntakeForSelectedDate = waterIntake;
      });
    } catch (error) {
      print('Error fetching water intake data: $error');
    }
  }

  Future<String> getExerciseName(
      String? setExerciseKey, String exerciseName) async {
    final exerciseBox = await Hive.openBox<ExerciseModel>('exercises');
    try {
      if (int.parse(setExerciseKey??'')>76) {
        final exercise = exerciseBox.values.firstWhere(
          (exercise) => exercise.exerciseKey == setExerciseKey,
        );
        final name = exercise.name;
        return name;
      } else {
        return exerciseName;
      }
    } catch (error) {
      print('Error getting exercise name: $error');
      return '';
    }
  }

  Map<String, List<SetModel>> groupSetsByExercise() {
    Map<String, List<SetModel>> groupedSets = {};
    for (var set in listOfSetsForTheDay) {
      String key = set.exerciseKey?.toString() ?? '';
      if (!groupedSets.containsKey(key)) {
        groupedSets[key] = [];
      }
      groupedSets[key]!.add(set);
    }
    return groupedSets;
  }
}
