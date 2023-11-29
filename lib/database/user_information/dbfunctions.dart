// import 'package:fitnessapplication/database/user_information/userdata.dart';
// import 'package:hive_flutter/hive_flutter.dart';


// // to store users data in hive
// Future<void> storeUserInDatabase(User value) async {
//   final userbox = Hive.box<User>('user_db');
//   userbox.add(value);
// }

// // to check whether the data is present or not to go directly to homepage
// bool isUserDataPresent() {
//   final userBox = Hive.box<User>('user_db');
//   if (userBox.isEmpty) {
//     return true;
//   } else {
//     return false;
//   }
// }

// // to get users data from hive
// Future<User?> getUserFromHive() async {
//   final box = await Hive.openBox<User>('user_db'); // Open the box
//   final userdetails = box.get(0);
//   await box.close();
//   return userdetails;
// }

// // to update users data
// Future<void> updateUserDetails(User updatedUser) async {
//   final userBox = await Hive.openBox<User>('user_db'); // Open the box
//   userBox.putAt(0, updatedUser);
//   await userBox.close();
// }
