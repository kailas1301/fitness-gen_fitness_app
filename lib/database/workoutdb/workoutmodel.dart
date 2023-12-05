import 'package:hive/hive.dart';
part 'workoutmodel.g.dart';

@HiveType(typeId: 2)
class CategoryModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String? categoryKey;
  CategoryModel({required this.name, this.categoryKey});
}

@HiveType(typeId: 3)
class ExerciseModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  CategoryModel category;
  @HiveField(2)
  String? categoryKey;
  @HiveField(3)
  String? exerciseKey;

  ExerciseModel(
      {required this.name,
      required this.category,
      this.categoryKey,
      this.exerciseKey});
}

@HiveType(typeId: 4)
class SetModel {
  @HiveField(0)
  String exerciseId;
  @HiveField(1)
  String weight;
  @HiveField(2)
  String reps;
  @HiveField(3)
  DateTime date;
  @HiveField(4)
  String? exerciseKey;
  @HiveField(5)
  String? setKey; 
  @HiveField(6)
  ExerciseModel exercise;

 SetModel({required this .exerciseId,
  required this.weight,
  required this.reps,
  required this.date,
  this.exerciseKey,
  this.setKey,
  required this.exercise});
}
