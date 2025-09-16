import 'package:flutter/material.dart';

class TermsConditionsView extends StatelessWidget {
  const TermsConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 16),
            Text('Assalamu alaikum,', style: TextStyle(fontSize: 16)),
            SizedBox(height: 12),
            Text(
              'bicharachar.com is a social media platform, set to increase awareness among people about law and order. We aim to facilitate communication among people of different classes, so that lawyers can maintain communication with their clients, clients may easily reach the lawyers. This platform is not completely secured like any other social media platform, therefore we encourage you to be cautious about sharing sensitive data. Also, we highly encourage you to verify people you meet here before going for any deal or contract.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

