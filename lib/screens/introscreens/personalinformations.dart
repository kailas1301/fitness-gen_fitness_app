import 'dart:io';
import 'package:fitnessapplication/database/userinformation/dbfunctions.dart';
import 'package:fitnessapplication/database/userinformation/userdata.dart';
import 'package:fitnessapplication/screens/bottomnav/bottomnavigationscreen.dart';
import 'package:fitnessapplication/widgets/textformfield_widget.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController glassController = TextEditingController();
  File? selectedImage;
  String selectedGender = 'Male';
  Future<File?> getImgageFromGallery() async {
    File? image;
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    return image;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          color: Colors.grey.shade200,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(
                          'Enter Your Informations',
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        )),
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              File? pickedImage = await getImgageFromGallery();
                              setState(() {
                                selectedImage = pickedImage;
                              });
                            },
                            child: Column(
                              children: [
                                SizedBox(height: screenHeight * 0.042),
                                CircleAvatar(
                                  radius: screenWidth * 0.20,
                                  backgroundColor: Colors.grey,
                                  child: selectedImage != null
                                      ? ClipOval(
                                          child: Image.file(
                                            File(selectedImage!.path),
                                            height: screenWidth * 0.5,
                                            width: screenWidth * 0.5,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Center(
                                          child: Icon(Icons.add_a_photo,
                                              size: 20, color: Colors.white),
                                        ),
                                ),
                                SizedBox(height: screenHeight * 0.032),
                              ],
                            ),
                          ),
                        ),
                        TextFormFieldWidget(
                          controller: nameController,
                          labeltext: 'Full Name',
                          errorText: 'Please enter your full name',
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFormFieldWidget(
                          optionalerror: 'Please enter a valid number',
                          keyboardType: TextInputType.number,
                          controller: ageController,
                          labeltext: 'Age',
                          errorText: 'Please enter your age',
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFormFieldWidget(
                          keyboardType: TextInputType.number,
                          controller: weightController,
                          labeltext: 'Weight (kg)',
                          errorText: 'Please enter your weight',
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFormFieldWidget(
                          keyboardType: TextInputType.number,
                          labeltext: 'Height (cm)',
                          controller: heightController,
                          errorText: 'Please enter your Height',
                        ),
                        SizedBox(height: screenHeight * 0.045),
                        const Text('Gender:', style: TextStyle(fontSize: 16)),
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
                            const Text('Female'),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'No of Glasses of water you need to drink.',
                          style: GoogleFonts.poppins(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFormFieldWidget(
                          keyboardType: TextInputType.number,
                          labeltext: 'No of Glasses',
                          controller: glassController,
                          errorText: 'Please enter a valid number',
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        ElevatedButton(
                          onPressed: () {
                            if ((formKey.currentState!.validate()) &&
                                selectedImage != null &&
                                int.parse(glassController.text) != 0) {
                              storeUserInDatabase(User(
                                limitOfGlass: glassController.text,
                                imagepath: selectedImage!.path,
                                fullName: nameController.text,
                                age: ageController.text,
                                weight: weightController.text,
                                height: heightController.text,
                                gender: selectedGender.toString(),
                              ));
                              // Save user details to Hive
                              showSnackbar(
                                  context, 'Information saved!', Colors.green);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const BottomNavScrn(),
                                ),
                              );
                            } else if (selectedImage == null) {
                              showSnackbar(context, 'Please select an image ',
                                  Colors.red);
                            } else {
                              showSnackbar(
                                  context,
                                  'Please give valid informations ',
                                  Colors.red);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 103, 39, 176),
                            minimumSize:
                                Size(double.infinity, screenHeight * 0.07),
                          ),
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ),
                ),
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
