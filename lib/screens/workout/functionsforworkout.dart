import 'package:fitnessapplication/database/workoutdb/workoutmodel.dart';
import 'package:fitnessapplication/screens/workout/exercises.dart';
import 'package:fitnessapplication/screens/workout/setscreen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// Functions for category


// to get the categories in a list
Future<List<CategoryModel>> getCategories() async {
  final categoryBox = await Hive.openBox<CategoryModel>('category_box');
  return categoryBox.values.toList();
}

// to add a new category
Future<void> addCategory(CategoryModel value) async {
  final categoryBox = await Hive.openBox<CategoryModel>('category_box');
  final timeKey = DateTime.now().millisecondsSinceEpoch;
  String key = timeKey.toString();
  value.categoryKey = key;

  print('${value.categoryKey} categorykey');
  await categoryBox.put(key, value);
}

// to dlete a new category
void deleteCategory(CategoryModel category, String key) {
  // creating a instance of boxes of category exercise and sets
  final categoryBox = Hive.box<CategoryModel>('category_box');
  final exerciseBox = Hive.box<ExerciseModel>('exercises');
  final setBox = Hive.box<SetModel>('sets');

// Find exercise associated with the category and make it a list
  final exercisesToDelete = exerciseBox.values
      .where(
          (exercise) => exercise.category.categoryKey == category.categoryKey)
      .toList();
// finding the index of the exercise in the list
  for (var exercise in exercisesToDelete) {
    final exerciseIndex = exerciseBox.values.toList().indexOf(exercise);
    // create a list of sets related to a exercise
    final setsToDelete = setBox.values
        .where((set) => set.exerciseKey == exercise.exerciseKey)
        .toList();

    // find the index of sets and delete it
    for (var set in setsToDelete) {
      final setIndex = setBox.values.toList().indexOf(set);
      setBox.deleteAt(setIndex);
    }
    // delete the exercise
    exerciseBox.deleteAt(exerciseIndex);
  }
  // Delete the category itself
  // final index = categoryBox.values.toList().indexOf(category);
  categoryBox.delete(key);
}

// to update the category
void updateCategory(
    CategoryModel updatedCategory, int index, String categoryKey) async {
  final categoryBox = await Hive.openBox<CategoryModel>('category_box');
  categoryBox.put(categoryKey, updatedCategory);
}

// functions for exercise

// to add a new exercise
Future<void> addExercise(ExerciseModel value) async {
  final exerciseBox = await Hive.openBox<ExerciseModel>('exercises');
  // to pass a unique key based on the time
  final timeKey = DateTime.now().millisecondsSinceEpoch;
  String key = timeKey.toString();
  value.exerciseKey = key;
  print('${value.categoryKey} categorykeyforexercise');
  print('${value.exerciseKey} categorykeyforexercisexercisekey');
  await exerciseBox.put(key, value);
}

// top get the data of exercises into a list
Future<List<ExerciseModel>> getExercises() async {
  final exerciseBox = await Hive.openBox<ExerciseModel>('exercises');
  return exerciseBox.values.toList();
}

// to update a exercise
Future<void> updateExercise(
    ExerciseModel updatedExercise, int index, String key) async {
  final exerciseBox = await Hive.openBox<ExerciseModel>('exercises');
  if (updatedExercise.exerciseKey == null) {}
  await exerciseBox.put(key, updatedExercise);
}

// function to delete a exercise
Future<void> deleteAnExercise(ExerciseModel exercise, String key) async {
  final exerciseBox = await Hive.openBox<ExerciseModel>('exercises');
  final setBox = await Hive.openBox<SetModel>('sets');

  // delete the sets
  final setsToDelete = setBox.values
      .where((set) => set.exerciseKey == exercise.exerciseKey)
      .toList();
  for (var set in setsToDelete) {
    final setIndex = setBox.values.toList().indexOf(set);
    setBox.deleteAt(setIndex);
  }
  // final index = exerciseBox.values.toList().indexOf(exercise);
  exerciseBox.delete(key);
}

// functions for exercise sets.

Future<void> addSet(SetModel value) async {
  final setBox = await Hive.openBox<SetModel>('sets');
  // to pass a unique key based on the time
  final timeKey = DateTime.now().millisecondsSinceEpoch;
  String key = timeKey.toString();
  value.setKey = key;
  setBox.put(key, value);
}

// to get the sets data to a list
Future<List<SetModel>> getSets() async {
  final setBox = await Hive.openBox<SetModel>('sets');
  return setBox.values.toList();
}

// to update the sets using key
Future<void> updateSet(String key, SetModel updatedSet) async {
  final setBox = await Hive.openBox<SetModel>('sets');
  await setBox.put(key, updatedSet);
}

// to deleta a set using key
Future<void> deleteSetByExerciseId( String key, List<SetModel> setsList) async {
  final setBox = await Hive.openBox<SetModel>('sets');
  await setBox.delete(key);
}

// get the set for the day
Future<List<SetModel>> getSetDataForTheDay(DateTime selectedDate) async {
  final setBox = await Hive.openBox<SetModel>('sets');
  final setList = setBox.values
      .where((e) =>
          e.date.year == selectedDate.year &&
          e.date.month == selectedDate.month &&
          e.date.day == selectedDate.day)
      .toList();
  return setList;
}

// to delete a set from the database

Future<void> deleteSet(
    {required int index,
    required List<SetModel> setsData,
    required BuildContext context,
   }) async{
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
              deleteSetByExerciseId(
                  setToDelete.setKey ?? '', setsData);
              Navigator.of(context).pop();
             
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}

// to navigate to new exercise screen
  void navigateToExercisesScreen(CategoryModel category,BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ExerciseListScreen(
        category: category,
      ),
    ));
  }

  // to navigate to setEntry screen after touching a exercise ;

  void navigateToSetEntryScreen(
      String exerciseName, ExerciseModel currentExercise,BuildContext context) {
    Navigator.push( 
      context,
      MaterialPageRoute(
        builder: (context) => SetEntryScreen(
            exerciseName: exerciseName, exerciseAtIndex: currentExercise),
      ),
    );
  }