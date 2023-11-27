import 'package:fitnessapplication/database/workoutdb/workoutmodel.dart';
import 'package:fitnessapplication/screens/workout/functionsforworkout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class SetEntryScreen extends StatefulWidget {
  final String exerciseName;
  final ExerciseModel exerciseAtIndex;

  const SetEntryScreen({super.key, required this.exerciseName, required this.exerciseAtIndex});

  @override
  State<SetEntryScreen> createState() => _SetEntryScreenState();
}

class _SetEntryScreenState extends State<SetEntryScreen> {
  List<SetModel> setsData = [];
  final TextEditingController weightController = TextEditingController();
  final TextEditingController repsController = TextEditingController();
  DateTime today = DateTime.now();

  @override
  void initState() {
    super.initState();
    loadSets();
  }

  Future<void> loadSets() async {
    final setBox = await Hive.openBox<SetModel>('sets');
    final exerciseSets = setBox.values
        .where((set) =>
        widget.exerciseAtIndex.exerciseKey==null?
         set.exerciseId == widget.exerciseAtIndex.name &&
            set.date.year == today.year &&
            set.date.month == today.month &&
            set.date.day == today.day:
            set.exercise.exerciseKey == widget.exerciseAtIndex.exerciseKey &&
            set.date.year == today.year &&
            set.date.month == today.month &&
            set.date.day == today.day)
        .toList();
    setState(() {
      setsData = exerciseSets;
    });
  }
// Future<void> loadSets() async {
//   final setBox = await Hive.openBox<SetModel>('sets');
//   List<SetModel> exerciseSets;

//   if (widget.exerciseAtIndex.exerciseKey == null) {
//     // Sort by exercise name and ID if exerciseKey is null
//     exerciseSets = setBox.values
//         .where((set) =>
//             set.exercise.name == widget.exerciseName &&
//             set.date.year == today.year &&
//             set.date.month == today.month &&
//             set.date.day == today.day)
//         .toList()
//         ..sort((a, b) {
//           // Custom sorting logic based on exercise name and ID
//           final result = a.exerciseId.compareTo(b.exerciseId);
//           if (result == 0) {
//             return a.exercise.name.compareTo(b.exercise.name);
//           }
//           return result;
//         });
//   } else {
//     // Use the existing method if exerciseKey is not null
//     exerciseSets = setBox.values
//         .where((set) =>
//             set.exerciseKey == widget.exerciseAtIndex.exerciseKey &&
//             set.date.year == today.year &&
//             set.date.month == today.month &&
//             set.date.day == today.day)
//         .toList();
//   }

//   setState(() {
//     setsData = exerciseSets;
//   });
// }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Sets for ${widget.exerciseName}',
          style: const TextStyle(color: Colors.deepPurple),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.deepPurple,
            )),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.calendar_month,
              color: Colors.deepPurple,
            ),
            onPressed: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: today,
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              if (selectedDate != null && selectedDate != today) {
                setState(() {
                  today = selectedDate;
                });
                loadSets();
              }
            },
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: setsData.isEmpty
            ? const Center(
                child: Text('No sets done today'),
              )
            : ListView.builder(
                itemCount: setsData.length,
                itemBuilder: (context, index) {
                  final set = setsData[index];
                  return Padding(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 25),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 234, 232, 237),
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 214, 208, 225),
                                Color.fromARGB(255, 205, 188, 237)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
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
                          padding: EdgeInsets.all(screenWidth * .035),
                          child: ListTile(
                            title: Text(
                                'Weight: ${set.weight} kg, Reps: ${set.reps}',
                                style: GoogleFonts.poppins(
                                    fontSize: screenWidth * .04,
                                    fontWeight: FontWeight.w600)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    editSetDialog(index,set);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    deleteSet(index);
                                    loadSets();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));
                },
              ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: screenWidth * .12),
        child: FloatingActionButton(
          onPressed: () {
            showSetEntryDialog();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

//functions

  void showSetEntryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Set for ${widget.exerciseName}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                controller: weightController,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: repsController,
                decoration: const InputDecoration(labelText: 'Reps'),
              ),
            ],
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
                final weight = weightController.text;
                final reps = repsController.text;

                if (weight.isNotEmpty && reps.isNotEmpty) {
                  final exerciseSet = SetModel(exercise:widget.exerciseAtIndex ,exerciseId:  widget.exerciseName,exerciseKey: widget.exerciseAtIndex.exerciseKey,
                   weight:int.parse(weight),reps:  int.parse(reps),date:  today);
                  addSet(exerciseSet);
                  loadSets();
                  Navigator.of(context).pop();
                  weightController.clear();
                  repsController.clear();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void editSetDialog(int index,SetModel currentExerciseSet) {
    weightController.text = setsData[index].weight.toString();
    repsController.text = setsData[index].reps.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Set'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                controller: weightController,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: repsController,
                decoration: const InputDecoration(labelText: 'Reps'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                weightController.clear();
                repsController.clear();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final weight = weightController.text;
                final reps = repsController.text;

                if (weight.isNotEmpty && reps.isNotEmpty) {
                  final updatedSet =SetModel(exercise: widget.exerciseAtIndex,exerciseId: widget.exerciseName,exerciseKey: widget.exerciseAtIndex.exerciseKey,setKey: currentExerciseSet.setKey,
                    weight:   int.parse(weight),reps:  int.parse(reps),date:  today);
                  updateSet(updatedSet.setKey??'', updatedSet);
                  Navigator.of(context).pop();
                  weightController.clear();
                  repsController.clear();
                  loadSets();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void deleteSet(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Set?'),
          content: const Text('Are you sure you want to delete this set?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final setToDelete = setsData[index];
                deleteSetByExerciseId(setToDelete.exerciseId, setToDelete.setKey??'', setsData);
                Navigator.of(context).pop();
                loadSets();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
