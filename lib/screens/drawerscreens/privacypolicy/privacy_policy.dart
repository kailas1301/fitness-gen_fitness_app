import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(leading: IconButton(onPressed: () {
        Navigator.pop(context);
      }, icon: const Icon(Icons.arrow_back,color: Colors.black,)),
        title: const Text('Privacy Policy',style: TextStyle(color: Colors.black),),centerTitle: true,elevation: 0,backgroundColor: Colors.white,
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
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We may collect the following types of information:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('- Personal Information: [Description]', style: TextStyle(fontSize: 16)),
              Text('- Usage Data: [Description]', style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text(
                '2. How We Use Your Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text('We use the collected information for [purposes].', style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text(
                '3. Security',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text('We prioritize the security of your information, but no method of transmission over the internet or electronic storage is completely secure. We cannot guarantee absolute security.', style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text(
                '4. Changes to This Privacy Policy',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text('We may update our Privacy Policy from time to time. You are advised to review this page periodically for any changes.', style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Text(
                '5. Contact Us',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text('If you have any questions about this Privacy Policy, please contact us at [contact email].', style: TextStyle(fontSize: 16, color: Colors.blue)),
            ],
          ),
        ),
      ),
    );
  }
}
