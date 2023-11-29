import 'package:flutter/material.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  final String appName = 'FitGen';
  final String version = '1.0.0';   
  final String developer = 'Kailas A Anil';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'About App',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$appName v$version',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
               'Welcome to $appName, your ultimate fitness companion designed to empower you on your health and wellness journey. Stay active, stay healthy!',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Key Features:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '• Personalized Workouts: Create your customized workout plans to match your goals.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800], // Adjust color for emphasis
              ),
            ),
            Text(
              '• Health Tracking: Monitor your steps, water consumption, and more.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800], // Adjust color for emphasis
              ),
            ), Text(
              '•Calorie calculator to calculate your maintainence and your goal calorie to achieve your goal weight.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800], // Adjust color for emphasis
              ),
            ),
            Text(
              '• Reminders: Stay on track with notifications for workouts and hydration.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800], // Adjust color for emphasis
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Developer: $developer',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Contact us: support at :',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),            const Text(
             'kailaskailu56@gmail.com',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}