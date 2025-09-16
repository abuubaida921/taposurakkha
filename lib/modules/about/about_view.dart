import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Bichar Achar')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 16),
              Text('Assalamu alaikum,', style: TextStyle(fontSize: 16)),
              SizedBox(height: 12),
              Text(
                'Bichar Achar is a part of a campaign “Make judiciary digital” introduced by K.S. Azim, a 34 years old entrepreneur from Uttara, Dhaka, Bangladesh, founder of Bichar Achar. This is an online based platform designed primarily to ease the sufferings of people by providing a platform for free interactions between the citizens and the legal professionals.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12),
              Text(
                'Users: Users can interact each other by private live chatting, Posts etc., can learn various legal matters by posting questions, reaching lawyers directly by texting them, also can get updates of their relevant cases through this platform.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12),
              Text(
                'Law Professionals: For the law professionals, this platform is a nice opportunity to enjoy many free services including Vairtual Chamber/Firm Management system, Client Pool System, Case Management System - where they can add all relevant people of a particular case and share information, files among them with privacy, from anywhere of the world. They can also get chance of earning money by providing legal help to people.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 12),
              Text(
                'We are working to bring more and more new features and services that would remove sufferings of people for getting legal help Insha Allah. The very next feature we are working on is the integration of Virtual Court, that can help many people to get proper legal information regarding a particular case and provide people the court orders etc.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

