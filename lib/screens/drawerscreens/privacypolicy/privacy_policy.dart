import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
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
          'Privacy Policy',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy for FitGen',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Effective Date: 27/11/2023',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '1. Information We Collect',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors
                      .deepPurple, // Use a color that matches your app's theme
                ),
              ),
              SizedBox(height: 8),
              Text(
                'At FitGen, we prioritize your privacy and aim to provide you with a personalized fitness experience. To achieve this, we may collect the following types of information:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Personal Information: Elevate your fitness journey by sharing details like your name, age, height, weight, and gender. This information enables us to tailor our services specifically to you, ensuring a customized and effective workout experience.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
// Add more specific details about the usage data you collect
SizedBox(height: 16),

              SizedBox(height: 16),
Text(
  '2. How We Use Your Information',
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.deepPurple, // Use a color that matches your app's theme
  ),
),
SizedBox(height: 8),
Text(
  'Your information is valuable to us, and we utilize it thoughtfully to enhance your FitGen experience. Our purposes for using your information include, but are not limited to:',
  style: TextStyle(
    fontSize: 16,

  ),
),
SizedBox(height: 8),
Text(
  'Personalized Workouts: Crafting workouts tailored to your fitness goals and preferences.',
  style: TextStyle(
    fontSize: 16,

  ),
),SizedBox(height: 8),
Text(
  'Performance Insights: Providing detailed insights to track and improve your fitness progress.',
  style: TextStyle(
    fontSize: 16,

  ),
),SizedBox(height: 8),
Text(
  'App Enhancements: Continuously improving and customizing our app based on user feedback.',
  style: TextStyle(
    fontSize: 16,

  ),
),
// Add more specific purposes as needed
SizedBox(height: 16),

              Text(
                '3. Security',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                  'We prioritize the security of your information. However, no method of transmission over the internet or electronic storage is completely secure. We cannot guarantee absolute security.',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text(
                '4. Changes to This Privacy Policy',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                  'We may update our Privacy Policy from time to time. You are advised to review this page periodically for any changes.',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text(
                '5. Contact Us',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                  'If you have any questions about this Privacy Policy, please contact us at ',
                  style: TextStyle(fontSize: 16, color: Colors.blue)),
                                Text(
                  'kailaskailu56@gmail.com.',
                  style: TextStyle(fontSize: 16, color: Colors.blue)),
            ],
          ),
        ),
      ),
    );
  }
}
