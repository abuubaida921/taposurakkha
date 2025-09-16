import 'package:flutter/material.dart';

class HeatwaveSafetyTipsView extends StatelessWidget {
  const HeatwaveSafetyTipsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('তাপপ্রবাহ সতর্কতা')), // Heatwave Safety Tips
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              'তাপপ্রবাহের সময় করণীয়:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('• প্রচুর পানি পান করুন\n• সরাসরি রোদ এড়িয়ে চলুন\n• হালকা ও ঢিলেঢালা পোশাক পরুন\n• অপ্রয়োজনীয় বাহিরে যাতায়াত এড়িয়ে চলুন\n• শিশু, বৃদ্ধ ও অসুস্থদের বিশেষ যত্ন নিন', style: TextStyle(fontSize: 16)),
            SizedBox(height: 24),
            Text('তাপপ্রবাহের লক্ষণ দেখলে দ্রুত চিকিৎসা নিন।', style: TextStyle(fontSize: 16, color: Colors.red)),
          ],
        ),
      ),
    );
  }
}

