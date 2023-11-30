import 'package:fitnessapplication/database/workoutdb/workoutmodel.dart';
import 'package:fitnessapplication/screens/workout/functionsforworkout.dart';
import 'package:fitnessapplication/screens/workout/setscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class ExerciseListScreen extends StatefulWidget {
  final CategoryModel category;
  const ExerciseListScreen({super.key, required this.category});

  @override
  State<ExerciseListScreen> createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {
  String exerciseName = '';
  int? lengthOfList;
  Map<String, List<ExerciseModel>> predefinedExercisesMap = {};
  List<ExerciseModel> exercises = [];
  TextEditingController exerciseNameController = TextEditingController();
  TextEditingController editExerciseController = TextEditingController();
  bool isPredifined = false;
  @override
  void initState() {
    loadExercises();
    super.initState();
  }

// to fetch the exercise which are predefined or userdefined related to the category
  Future<void> loadExercises() async {
    Map<String, List<ExerciseModel>> predefinedExercisesMap = {
      "CHEST": [
        ExerciseModel(
            name: "Push-Ups", category: widget.category, exerciseKey: '7'),
        ExerciseModel(
            name: "Bench Press", category: widget.category, exerciseKey: '8'),
        ExerciseModel(
            name: "Chest Fly", category: widget.category, exerciseKey: '9'),
        ExerciseModel(
            name: "Incline Bench Press",
            category: widget.category,
            exerciseKey: '10'),
        ExerciseModel(
            name: "Dumbbell Pullover",
            category: widget.category,
            exerciseKey: '11'),
        ExerciseModel(
            name: "Cable Crossover",
            category: widget.category,
            exerciseKey: '12'),
        ExerciseModel(
            name: "Decline Push-Ups",
            category: widget.category,
            exerciseKey: '13'),
        ExerciseModel(
            name: "Dumbbell Bench Press",
            category: widget.category,
            exerciseKey: '14'),
        ExerciseModel(
            name: "Machine Chest Press",
            category: widget.category,
            exerciseKey: '15'),
        ExerciseModel(
            name: "Decline Bench Press",
            category: widget.category,
            exerciseKey: '16'),
        ExerciseModel(
            name: "Decline Dumbell Press",
            category: widget.category,
            exerciseKey: '17'),
      ],
      "TRICEPS": [
        ExerciseModel(
            name: "Tricep Dips", category: widget.category, exerciseKey: '18'),
        ExerciseModel(
            name: "Overhead Tricep Extension",
            category: widget.category,
            exerciseKey: '19'),
        ExerciseModel(
            name: "Tricep Kickbacks",
            category: widget.category,
            exerciseKey: '20'),
        ExerciseModel(
            name: "Close-Grip Bench Press",
            category: widget.category,
            exerciseKey: '21'),
        ExerciseModel(
            name: "Skull Crushers",
            category: widget.category,
            exerciseKey: '22'),
        ExerciseModel(
            name: "Tricep Pushdowns",
            category: widget.category,
            exerciseKey: '23'),
        ExerciseModel(
            name: "Bench Dips", category: widget.category, exerciseKey: '24'),
        ExerciseModel(
            name: "Rope Tricep Pushdown",
            category: widget.category,
            exerciseKey: '25'),
      ],
      "BACK": [
        ExerciseModel(
            name: "Deadlifts", category: widget.category, exerciseKey: '26'),
        ExerciseModel(
            name: "Lat Pulldowns",
            category: widget.category,
            exerciseKey: '27'),
        ExerciseModel(
            name: "Rows (Barbell)",
            category: widget.category,
            exerciseKey: '28'),
        ExerciseModel(
            name: "Pull-Ups", category: widget.category, exerciseKey: '29'),
        ExerciseModel(
            name: "Face Pulls", category: widget.category, exerciseKey: '30'),
        ExerciseModel(
            name: "T-Bar Rows", category: widget.category, exerciseKey: '31'),
        ExerciseModel(
            name: "Seated Cable Rows",
            category: widget.category,
            exerciseKey: '32'),
        ExerciseModel(
            name: "Romanian Deadlifts",
            category: widget.category,
            exerciseKey: '33'),
        ExerciseModel(
            name: "Bent Over Rows",
            category: widget.category,
            exerciseKey: '34'),
        ExerciseModel(
            name: "Hyperextensions",
            category: widget.category,
            exerciseKey: '35'),
        ExerciseModel(name: "Chin-Ups", category: widget.category),
        ExerciseModel(
            name: "One-Arm Dumbbell Rows",
            category: widget.category,
            exerciseKey: '36'),
        ExerciseModel(
            name: "Wide-Grip Pulldowns",
            category: widget.category,
            exerciseKey: '37'),
      ],
      "BICEPS": [
        ExerciseModel(
            name: "Bicep Curls (Barbell)",
            category: widget.category,
            exerciseKey: '38'),
        ExerciseModel(
            name: "Hammer Curls", category: widget.category, exerciseKey: '39'),
        ExerciseModel(
            name: "Concentration Curls",
            category: widget.category,
            exerciseKey: '40'),
        ExerciseModel(
            name: "Preacher Curls",
            category: widget.category,
            exerciseKey: '41'),
        ExerciseModel(
            name: "Reverse Curls",
            category: widget.category,
            exerciseKey: '42'),
        ExerciseModel(
            name: "Cable Curl", category: widget.category, exerciseKey: '43'),
        ExerciseModel(
            name: "EZ Bar Curls", category: widget.category, exerciseKey: '44'),
        ExerciseModel(
            name: "Spider Curls", category: widget.category, exerciseKey: '45'),
        ExerciseModel(
            name: "Incline Dumbbell Curls",
            category: widget.category,
            exerciseKey: '46'),
        ExerciseModel(
            name: "Zottman Curls",
            category: widget.category,
            exerciseKey: '47'),
        ExerciseModel(
            name: "21s", category: widget.category, exerciseKey: '48'),
        ExerciseModel(
            name: "Reverse Grip Barbell Curl",
            category: widget.category,
            exerciseKey: '49'),
        ExerciseModel(
            name: "Cross Body Hammer Curl",
            category: widget.category,
            exerciseKey: '50'),
      ],
      "SHOULDERS": [
        ExerciseModel(
            name: "Arnold Press", category: widget.category, exerciseKey: '51'),
        ExerciseModel(
            name: "Lateral Raises",
            category: widget.category,
            exerciseKey: '52'),
        ExerciseModel(
            name: "Front Raises", category: widget.category, exerciseKey: '53'),
        ExerciseModel(
            name: "Shrugs", category: widget.category, exerciseKey: '54'),
        ExerciseModel(
            name: "Upright Rows", category: widget.category, exerciseKey: '55'),
        ExerciseModel(
            name: "Face Pulls", category: widget.category, exerciseKey: '56'),
        ExerciseModel(
            name: "Reverse Flyes",
            category: widget.category,
            exerciseKey: '57'),
        ExerciseModel(
            name: "Shoulder Taps",
            category: widget.category,
            exerciseKey: '58'),
        ExerciseModel(
            name: "Cuban Press", category: widget.category, exerciseKey: '59'),
        ExerciseModel(
            name: "Dumbbell Shoulder Press",
            category: widget.category,
            exerciseKey: '60'),
        ExerciseModel(
            name: "Seated Dumbbell Lateral Raise",
            category: widget.category,
            exerciseKey: '61'),
        ExerciseModel(
            name: "Barbell Shoulder Press",
            category: widget.category,
            exerciseKey: '62'),
        ExerciseModel(
            name: "Machine Shoulder Press",
            category: widget.category,
            exerciseKey: '63'),
      ],
      "LEGS": [
        ExerciseModel(
            name: "Squats (Back Squats)",
            category: widget.category,
            exerciseKey: '64'),
        ExerciseModel(
            name: "Lunges", category: widget.category, exerciseKey: '65'),
        ExerciseModel(
            name: "Leg Press", category: widget.category, exerciseKey: '66'),
        ExerciseModel(
            name: "Deadlifts", category: widget.category, exerciseKey: '67'),
        ExerciseModel(
            name: "Calf Raises", category: widget.category, exerciseKey: '68'),
        ExerciseModel(
            name: "Leg Extensions",
            category: widget.category,
            exerciseKey: '69'),
        ExerciseModel(
            name: "Leg Curls", category: widget.category, exerciseKey: '70'),
        ExerciseModel(
            name: "Box Jumps", category: widget.category, exerciseKey: '71'),
        ExerciseModel(
            name: "Step-Ups", category: widget.category, exerciseKey: '72'),
        ExerciseModel(
            name: "Bulgarian Split Squats",
            category: widget.category,
            exerciseKey: '73'),
        ExerciseModel(
            name: "Hack Squats", category: widget.category, exerciseKey: '74'),
        ExerciseModel(
            name: "Sumo Deadlifts",
            category: widget.category,
            exerciseKey: '75'),
        ExerciseModel(
            name: "Walking Lunges",
            category: widget.category,
            exerciseKey: '76'),
      ],
      // Can Add more predefined exercises for each category as needed
    };

// to check if the exercises category key and category category key are equal and putting into a list
    final exerciseBox = await Hive.openBox<ExerciseModel>('exercises');
    final categoryExercises = exerciseBox.values
        .where(
            (exercise) => exercise.categoryKey == widget.category.categoryKey)
        .toList();
// to check and put the predifined exercises related to the current category
    final predefinedExercises = predefinedExercisesMap[widget.category.name] ??
        []; // Get predefined exercises for the specific category
    setState(() {
      // joining the predefined exercises and the userdefined exercises
      exercises = [...categoryExercises, ...predefinedExercises];
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises for ${widget.category.name}',
            style: GoogleFonts.openSans(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            )),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.deepPurple,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            lengthOfList = exercises.length;
            // selecting a exercise which is in the current index
            final exerciseAtIndex = exercises[index];
            // checking the exercise is a predifined exercise or not
            if (int.parse(exerciseAtIndex.exerciseKey ?? '') < 76) {
              isPredifined = true;
            } else {
              isPredifined = false;
            }

            return Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 234, 232, 237),
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 214, 208, 225),
                    Color.fromARGB(255, 205, 188, 237)
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 10,
                        spreadRadius: 1),
                    BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(-2.0, -2.0),
                        blurRadius: 10,
                        spreadRadius: 1),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * .04),
                  child: ListTile(
                    title: Text(
                      exerciseAtIndex.name.toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * .045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      navigateToSetEntryScreen(
                          exerciseAtIndex.name, exerciseAtIndex);
                    },
                    trailing: isPredifined
                        ? null // No edit/delete buttons for predefined exercises
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  showEditExerciseDialog(
                                      index, lengthOfList!, exerciseAtIndex);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Delete Exercise?'),
                                        content: const Text(
                                          'Are you sure you want to delete this exercise?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              deleteAnExercise(
                                                  exerciseAtIndex,
                                                  exerciseAtIndex.exerciseKey ??
                                                      '');
                                              loadExercises();

                                              // Navigate to ExerciseListScreen again and clear the stack
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          ExerciseListScreen(
                                                              category: widget
                                                                  .category),
                                                ),
                                                (route) => route
                                                    .isFirst, // Remove all routes except the first one
                                              );
                                            },
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            );
          },
        ),
      ),

      // to show a dialougue box to add new exercises
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: screenWidth * .12),
        child: FloatingActionButton(
          onPressed: () {
            showExerciseDialog();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  //  functions

  // to show a dialougue box to add new exercises
  void showExerciseDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Exercise'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: exerciseNameController,
                decoration: const InputDecoration(labelText: 'Exercise Name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                exerciseNameController.clear();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // adding a new exercise
                String exerciseName = exerciseNameController.text;
                if (exerciseNameController.text.isNotEmpty) {
                  addExercise(ExerciseModel(
                      name: exerciseName,
                      category: widget.category,
                      categoryKey: widget.category.categoryKey));
                  loadExercises();
                  Navigator.of(context).pop();
                  exerciseNameController.clear();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

// to show a dialougue box to update exercise name
  void showEditExerciseDialog(
      int index, int length, ExerciseModel currentExercise) {
    editExerciseController.text = exercises[index].name;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Exercise'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: editExerciseController,
                decoration: const InputDecoration(labelText: 'Exercise Name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                editExerciseController.clear();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String exerciseName = editExerciseController.text;
                if (exerciseName.isNotEmpty) {
                  // to update a exercise

                  ExerciseModel updatedExercise = ExerciseModel(
                      name: exerciseName,
                      category: widget.category,
                      categoryKey: widget.category.categoryKey,
                      exerciseKey: currentExercise.exerciseKey);
                  updateExercise(updatedExercise, index,
                      currentExercise.exerciseKey ?? '');
                  loadExercises();
                  Navigator.of(context).pop();
                  editExerciseController.clear();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  } // to navigate to setEntry screen after touching a exercise ;

  void navigateToSetEntryScreen(
      String exerciseName, ExerciseModel currentExercise) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetEntryScreen(
            exerciseName: exerciseName, exerciseAtIndex: currentExercise),
      ),
    );
  }
}
