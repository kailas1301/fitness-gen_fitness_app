import 'package:fitnessapplication/database/userinformation/dbfunctions.dart';
import 'package:fitnessapplication/database/userinformation/userdata.dart';
import 'package:fitnessapplication/screens/homescreen/bmicontainer.dart';
import 'package:fitnessapplication/screens/homescreen/startworkoutcontainer.dart';
import 'package:fitnessapplication/screens/homescreen/steptracker.dart';
import 'package:fitnessapplication/screens/homescreen/watertracker.dart';
import 'package:fitnessapplication/screens/homescreen/drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int pageindex = 0;
  User? userdata;
  String? userImageFrmHive;
  double? userWeight;
  double? userHeight;
  double? bmiValue;
  int? glassLimit;
  @override
  void initState() {
    getUserFromHive().then((userbox) {
      setState(() {
        userdata = userbox;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    userImageFrmHive = userdata?.imagepath ?? '';
    userHeight = double.tryParse(userdata?.height ?? '') ?? 0.0;
    userWeight = double.tryParse(userdata?.weight ?? '') ?? 0.0;
    glassLimit = int.tryParse(userdata?.limitOfGlass ?? '') ?? 0;
    bmiValue = calculateBmi(
        heightForCalculatingBmi: userHeight!,
        weightForCalculatingBmi: userWeight!);

    return Scaffold(
      key: scaffoldKey,
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
              ),
              StartWorkoutContainer(
                  screenHeight: screenHeight, screenWidth: screenWidth),
              SizedBox(height: screenHeight * .04),
              Center(
                child: BmiContainer(
                    height: userHeight!,
                    weight: userWeight!,
                    bmiOfUserForDisplay: bmiValue!,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth),
              ),
              SizedBox(height: screenHeight * .04),
              Center(
                child: WarterTrackerContainer(
                    limitOfGlass: glassLimit!,
                    screenHeight: screenHeight,
                    screenWidth: screenWidth),
              ),
              SizedBox(height: screenHeight * .04),
              StepTrackerScrn(
                  screenWidth: screenWidth, screenHeight: screenHeight),
              SizedBox(height: screenHeight * .04)
            ],
          ),
        ],
      ),
      drawer: Drawer(
        width: screenWidth,
        elevation: 4,
        child: DrawerClass(
          userdata: userdata,
          userImageFrmHive: userImageFrmHive,
        ),
      ),
      // bottomNavigationBar: BottomNavWidget(selectedIndex: pageindex),
    );
  }
}
