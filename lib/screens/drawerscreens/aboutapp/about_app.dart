import 'package:flutter/material.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
 final String appName = 'FitGen';
  final String version = '1.0.0';
  final String description =
      'FitGen is your ultimate fitness companion, helping you achieve your health and wellness goals. Stay active, stay healthy!';
  final String developer = 'Kailas A Anil';

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(leading: IconButton(onPressed: () {
        Navigator.pop(context);
      }, icon: const Icon(Icons.arrow_back,color: Colors.black,)),
        title: const Text('About App',style: TextStyle(color: Colors.black),),centerTitle: true,elevation: 0,backgroundColor: Colors.white,
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
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Developer: $developer',
              style: const TextStyle(fontSize: 16)
            ),
            const SizedBox(height: 16),
            const Text(
              'Contact us: support@ kailaskailu56@gmail.com',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
