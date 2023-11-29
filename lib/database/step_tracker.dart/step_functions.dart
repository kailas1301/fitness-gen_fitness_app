import 'package:fitnessapplication/database/step_tracker.dart/step_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> addPreviousSteps(StepModel stepData,String previousSteps) async {
  final stepBox = await Hive.openBox<StepModel>('stepBox');
  await stepBox.put(0, stepData);
}


Future<String?> getPreviousSteps() async {
final stepBox = await Hive.openBox<StepModel>('stepBox');
final stepdata=stepBox.get(0);
final previousStepFromDb= stepdata!.previousSteps;
return previousStepFromDb;
}
