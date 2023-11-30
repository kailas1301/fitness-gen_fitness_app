 import 'package:fitnessapplication/database/workoutdb/workoutmodel.dart';
import 'package:hive/hive.dart';

Future<String> getExerciseName(
      String? setExerciseKey, String exerciseName) async {
    final exerciseBox = await Hive.openBox<ExerciseModel>('exercises');
    try {
      if (int.parse(setExerciseKey ?? '') > 76) {
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

    Map<String, List<SetModel>> groupSetsByExercise(List listOfSetsForTheDay) {
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

  