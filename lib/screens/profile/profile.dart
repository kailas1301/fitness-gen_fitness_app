import 'dart:io';
import 'package:fitnessapplication/database/userinformation/dbfunctions.dart';
import 'package:fitnessapplication/database/userinformation/userdata.dart';
import 'package:fitnessapplication/database/watertracker/watertrackerfunctions.dart';
import 'package:fitnessapplication/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int pageindex = 3;
  User? userdata;
  String? selectedImage;
  String? selectedGender;
  int? glasses;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController glassController = TextEditingController();
  @override
  void initState() {
    updateWaterIntakeForToday();
    getUserFromHive().then((userbox) {
      setState(() {
        userdata = userbox;
        selectedImage = userdata?.imagepath;
        selectedGender = userdata?.gender;
        nameController.text = userdata?.fullName ?? '';
        ageController.text = userdata?.age ?? '';
        weightController.text = userdata?.weight ?? '';
        heightController.text = userdata?.height ?? '';
        glassController.text = userdata?.limitOfGlass ?? '';
      });
    });
    super.initState();
  }

  Future<void> updateWaterIntakeForToday() async {
    final today = DateTime.now();
    final waterIntake = await getWaterIntakeForDate(today);
    setState(() {
      glasses = waterIntake;
    });
  }

  Future<void> updateUserData() async {
    if (selectedImage != null &&
        int.parse(glassController.text) >= int.parse(glasses.toString())) {
      final updatedUser = User(
        limitOfGlass: glassController.text,
        imagepath: selectedImage!,
        fullName: nameController.text,
        age: ageController.text,
        weight: weightController.text,
        height: heightController.text,
        gender: selectedGender ?? 'Male', // Default to 'Male'
      );

      await updateUserDetails(updatedUser);

      // ignore: use_build_context_synchronously
      showSnackbar(context, 'Information updated!', Colors.green);
    } else if (int.parse(glassController.text) <
        int.parse(userdata!.limitOfGlass)) {
      showSnackbar(context,
          'Already the goal is completed .Give a valid number', Colors.red);
    } else {
      showSnackbar(context, 'select image', Colors.red);
    }
  }

  Future<void> getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: screenHeight * .02),
                          Text(
                            'Edit Your Profile',
                            style: GoogleFonts.openSans(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w800,
                              fontSize: screenHeight * .025,
                            ),
                          ),
                          SizedBox(height: screenHeight * .02),
                          GestureDetector(
                              onTap: () async {
                                await getImageFromGallery();
                              },
                              child: Hero(
                                tag: 'userImageHero',
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Colors.grey,
                                  child: selectedImage != null
                                      ? ClipOval(
                                          child: Image.file(
                                            File(selectedImage!),
                                            height: 300,
                                            width: 300,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Center(
                                          child: Icon(
                                            Icons.add_a_photo,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              children: [
                                TextFormFieldWidget(
                                  prefixText: 'Name : ',
                                  controller: nameController,
                                  errorText: 'Enter your Name',
                                  keyboardType: TextInputType.name,
                                ),
                                SizedBox(height: screenHeight * .02),
                                TextFormFieldWidget(
                                  prefixText: 'Age : ',
                                  controller: ageController,
                                  errorText: 'Enter your Age',
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(height: screenHeight * .02),
                                TextFormFieldWidget(
                                    suffixText: 'kg',
                                    prefixText: 'Weight : ',
                                    controller: weightController,
                                    errorText: 'Enter your Weight',
                                    keyboardType: TextInputType.number),
                                SizedBox(height: screenHeight * .02),
                                TextFormFieldWidget(
                                  suffixText: 'cm',
                                  prefixText: 'Height : ',
                                  controller: heightController,
                                  errorText: 'Enter your Height',
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(height: screenHeight * .02),
                                Row(
                                  children: [
                                    Radio(
                                      value: 'Male',
                                      groupValue: selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGender = 'Male';
                                        });
                                      },
                                    ),
                                    const Text('Male'),
                                    Radio(
                                      value: 'Female',
                                      groupValue: selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGender = 'Female';
                                        });
                                      },
                                    ),
                                    const Text('Female')
                                  ],
                                ),
                                TextFormFieldWidget(
                                  suffixText: 'glasses',
                                  prefixText: 'Your goal : ',
                                  controller: glassController,
                                  errorText: 'Enter valid number',
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(height: screenHeight * .06),
                                ElevatedButton(
                                    onPressed: () {
                                      updateUserData();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 128, 83, 179),
                                        minimumSize:
                                            const Size(double.infinity, 50)),
                                    child: Text(
                                      'Save',
                                      style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w700,
                                        fontSize: screenHeight * .02,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showSnackbar(BuildContext context, String message, Color backgroundColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
      backgroundColor: backgroundColor,
    ),
  );
}
