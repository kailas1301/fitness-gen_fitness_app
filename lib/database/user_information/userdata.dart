import 'package:hive_flutter/hive_flutter.dart';
part 'userdata.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String imagepath;
  @HiveField(1)
  final String fullName;
  @HiveField(2)
  final String age;
  @HiveField(3)
  final String weight;
  @HiveField(4)
  final String height;
  @HiveField(5)
  final String gender;
  @HiveField(6)
  final String limitOfGlass;
  User({
    required this.imagepath,
    required this.fullName,
    required this.age,
    required this.weight,
    required this.height,
    required this.gender,
    required this.limitOfGlass,
  });
}
