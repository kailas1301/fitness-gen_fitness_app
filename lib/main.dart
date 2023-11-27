import 'package:fitnessapplication/database/userinformation/userdata.dart';
import 'package:fitnessapplication/database/watertracker/watertrackerdatabase.dart';
import 'package:fitnessapplication/database/workoutdb/workoutmodel.dart';
import 'package:fitnessapplication/local_notifications/local_noti.dart';
import 'package:fitnessapplication/screens/introscreens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  await Hive.initFlutter();
  Hive.registerAdapter(WaterIntakeAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(ExerciseModelAdapter());
  Hive.registerAdapter(SetModelAdapter());
  await Hive.openBox<User>('user_db');
  await Hive.openBox<WaterIntake>('water_intake_db');
  await Hive.openBox<CategoryModel>('category_box');
  await Hive.openBox<ExerciseModel>('exercises');
  await Hive.openBox<SetModel>('sets');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const SplashScreen(),
    );
  }
}
