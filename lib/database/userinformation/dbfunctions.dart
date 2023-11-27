import 'package:fitnessapplication/database/userinformation/userdata.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> storeUserInDatabase(User value) async {
  final userbox = Hive.box<User>('user_db');
  userbox.add(value);
}

bool isUserDataPresent() {
  final userBox = Hive.box<User>('user_db');
  if (userBox.isEmpty) {
    return true;
  } else {
    return false;
  }
}

Future<User?> getUserFromHive() async {
  final box = await Hive.openBox<User>('user_db'); // Open the box
  final userdetails = box.get(0);
  await box.close();
  return userdetails;
}

Future<void> updateUserDetails(User updatedUser) async {
  final userBox = await Hive.openBox<User>('user_db'); // Open the box
  userBox.putAt(0, updatedUser);
  await userBox.close();
}
