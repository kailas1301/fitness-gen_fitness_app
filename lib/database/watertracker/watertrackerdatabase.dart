import 'package:hive_flutter/hive_flutter.dart';
part 'watertrackerdatabase.g.dart';

@HiveType(typeId: 1)
class WaterIntake {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  int glasses;

  WaterIntake(this.date, this.glasses);
}
