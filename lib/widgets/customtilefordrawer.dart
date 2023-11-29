
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, 
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return ListTile(
      leading: Icon(icon, size: 30),
      title: Text(
        title,
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w700,
          fontSize: screenHeight * .02,
        ),
      ),
      onTap: onTap,
    );
  }
}