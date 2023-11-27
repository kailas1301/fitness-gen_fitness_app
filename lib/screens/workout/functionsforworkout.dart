import 'package:fitnessapplication/database/workoutdb/workoutmodel.dart';
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

Future<List<SetModel>> getSets() async {
  final setBox = await Hive.openBox<SetModel>('sets');
  return setBox.values.toList();
}

Future<void> updateSet(String key, SetModel updatedSet) async {
  final setBox = await Hive.openBox<SetModel>('sets');
  await setBox.put(key, updatedSet);
}

Future<void> deleteSetByExerciseId(
    String exerciseId, String key, List<SetModel> setsList) async {
  final setBox = await Hive.openBox<SetModel>('sets');
  // final setToDelete = setsList[index];
  // final sets =
  //     setBox.values.where((set) => set.exerciseId == exerciseId).toList();
  // final setIndex = sets.indexOf(setToDelete);
  // if (setIndex >= 0) {
  //   await setBox.deleteAt(setIndex);
  // }
  await setBox.delete(key);
}

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
