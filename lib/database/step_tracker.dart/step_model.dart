import 'package:hive/hive.dart';
part 'step_model.g.dart';
@HiveType(typeId: 5)
class StepModel {
  @HiveField(0)
  String? steps;
  @HiveField(1)
  String? previousSteps;
  @HiveField(2)
  DateTime? date;
  StepModel({this.previousSteps, this.steps,this.date});
}
