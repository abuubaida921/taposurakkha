import 'package:flutter/material.dart';

class HeatwaveInfoView extends StatelessWidget {
  const HeatwaveInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('তাপপ্রবাহের ধারনা'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              'তাপপ্রবাহ কী?\n\n'
              'তাপপ্রবাহ হল একটি সময়কাল, যখন তাপমাত্রা স্বাভাবিকের চেয়ে উল্লেখযোগ্যভাবে বেশি হয়ে যায় এবং এটি কমপক্ষে ৩ দিন স্থায়ী হয়। সাধারণত, তাপমাত্রা ৩৬°C বা তার বেশি হলে তাপপ্রবাহ ধরা হয়।',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'তাপপ্রবাহের প্রকারভেদ:\n- মৃদু: ৩৬°C–৩৮°C\n- মাঝারি: ৩৮°C–৪০°C\n- তীব্র: ৪০°C বা তার বেশি',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'তাপপ্রবাহের কারণ:\n- উচ্চচাপ বায়ুমণ্ডলীয় অবস্থা\n- শুষ্ক মৌসুমি বায়ু প্রবাহ\n- নগর এলাকায় তাপদ্বীপ প্রভাব\n- জলবায়ু পরিবর্তনের কারণে তাপমাত্রা বৃদ্ধি',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

