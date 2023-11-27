// import 'package:fitnessapplication/screens/homescreen/homescreen.dart';
// import 'package:fitnessapplication/screens/history/Historyscreen.dart';
// import 'package:fitnessapplication/screens/profile/profile.dart';
// import 'package:fitnessapplication/screens/workout/workoutcategory.dart';
// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';

// class BottomNavWidget extends StatefulWidget {
//   const BottomNavWidget({
//     super.key,
//     required this.selectedIndex,
//   });

//   final int selectedIndex;

//   @override
//   State<BottomNavWidget> createState() => _BottomNavWidgetState();
// }

// class _BottomNavWidgetState extends State<BottomNavWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: GNav(
//         padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//         tabBackgroundColor: Color.fromARGB(255, 238, 229, 243),
//         activeColor: Colors.deepPurple,
//         gap: 6,
//         iconSize: 18,
//         textSize: 10,
//         selectedIndex: widget.selectedIndex,
//         onTabChange: (int index) {
//           if (index != widget.selectedIndex && index == 0) {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => const HomeScreen(),
//               ),
//             );
//           } else if (index != widget.selectedIndex && index == 1) {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => const CategoryScrn(),
//               ),
//             );
//           } else if (index != widget.selectedIndex && index == 2) {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => const HistoryScrn(),
//               ),
//             );
//           } else if (index != widget.selectedIndex && index == 3) {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => const ProfileScreen(),
//               ),
//             );
//           }
//         },
//         tabs: const [
//           GButton(
//             icon: Icons.home_outlined,
//             text: 'Home',
//           ),
//           GButton(
//             icon: Icons.directions_walk_outlined,
//             text: 'Exercises',
//           ),
//           GButton(
//             icon: Icons.history,
//             text: 'History',
//           ),
//           GButton(
//             icon: Icons.person_outlined,
//             text: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }
