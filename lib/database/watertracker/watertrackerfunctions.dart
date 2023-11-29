import 'package:fitnessapplication/database/watertracker/watertrackerdatabase.dart';
import 'package:hive_flutter/hive_flutter.dart';


// to add glass of water
Future<void> addGlassOfWater(int numberOfGlasses) async {
  final today = DateTime.now();
  final formattedDate =
      '${today.year}${today.month.toString().padLeft(2, '0')}${today.day.toString().padLeft(2, '0')}';

  final waterIntakeBox = await Hive.openBox<WaterIntake>('water_intake_db');

  final existingData = waterIntakeBox.get(formattedDate);

  if (existingData != null) {
    existingData.glasses += 1;

    await waterIntakeBox.put(formattedDate, existingData);
  } else {
    final waterIntake = WaterIntake(today, 1);
    await waterIntakeBox.put(formattedDate, waterIntake);
  }
}


// to get the amount of water
Future<int> getWaterIntakeForDate(DateTime selectedDate) async {
  final formattedDate =
      '${selectedDate.year}${selectedDate.month.toString().padLeft(2, '0')}${selectedDate.day.toString().padLeft(2, '0')}';
  final waterIntakeBox = await Hive.openBox<WaterIntake>('water_intake_db');

  final waterIntake = waterIntakeBox.get(formattedDate);

  return waterIntake?.glasses ?? 0;
}
