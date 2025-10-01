import 'package:flutter/material.dart';

import 'model/heat_health_issue.dart';

class HeatwaveInfoView extends StatelessWidget {
   HeatwaveInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'তাপপ্রবাহের ধারনা', // Understanding Heatwaves
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Q1: What is a Heatwave?
            _buildInfoCard(
              title: 'তাপপ্রবাহ কী?',
              // What is a Heatwave?
              answer: 'তাপপ্রবাহ হলো একটি সময়কাল, যখন তাপমাত্রা স্বাভাবিকের চেয়ে উল্লেখযোগ্যভাবে বেশি হয়ে যায় এবং এটি কমপক্ষে ৩ দিন ধরে স্থায়ী হয়। সাধারণত, তাপমাত্রা ৩৬°C বা তার বেশি হয়ে থাকে।',
              // A heatwave is a period when the temperature becomes significantly higher than normal and lasts for at least 3 days. Usually, the temperature is 36°C or higher.
              icon: Icons.thermostat_outlined,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            // Q2: Types of Heatwaves in Bangladesh
            _buildInfoCard(
              title: 'বাংলাদেশে তাপপ্রবাহের প্রকারভেদ',
              // Types of Heatwaves in Bangladesh
              icon: Icons.stacked_bar_chart,
              color: Colors.green,
              children: [
                _buildBulletPoint('মৃদু: ৩৬°C–৩৮°C'),
                _buildBulletPoint('মাঝারি: ৩৮°C–৪০°C'),
                _buildBulletPoint('তীব্র: ৪০°C বা তার বেশি'),
              ],
            ),
            const SizedBox(height: 16),
            // Q3: Causes of Heatwaves
            _buildInfoCard(
              title: 'তাপপ্রবাহের কারণ কী?',
              // What are the Causes of Heatwaves?
              icon: Icons.whatshot_outlined,
              color: Colors.orange,
              children: [
                _buildBulletPoint(
                    'উচ্চচাপ বায়ুমণ্ডলীয় অবস্থা, ফলে গরম বাতাস জমে থাকা'),
                _buildBulletPoint('শুষ্ক মৌসুমি বায়ু প্রবাহ'),
                _buildBulletPoint(
                    'নগর এলাকায় তাপদ্বীপ প্রভাব (Urban Heat Island Effect)'),
                _buildBulletPoint('জলবায়ু পরিবর্তনের কারণে তাপমাত্রা বৃদ্ধি'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.deepOrange,
                      ),
                      children: [
                        TextSpan(
                          text: 'বর্ষার আগে গরমের সময় : ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'সূর্যের আলো খুব তীব্র হয়, মাটিতে আর্দ্রতা কম থাকে, আর গরম বাতাস ও শুকনো আবহাওয়া মিলে হিটওয়েভ তৈরি করে।',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Q4: Symptoms of Heat-Related Health Issues
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.sick_outlined, color: Colors.red, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'তাপপ্রবাহের সময় স্বাস্থ্যগত সংকটের লক্ষণ কী কী?',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...heatHealthIssues.map((issue) =>
                        _buildHealthIssueCard(issue)).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a card with a question and answer/list
  Widget _buildInfoCard({
    required String title,
    String? answer,
    List<Widget>? children,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (answer != null)
              Text(
                answer,
                style: const TextStyle(fontSize: 16),
              ),
            if (children != null) ...children,
          ],
        ),
      ),
    );
  }

  // Helper method for bullet points
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }


  final List<HeatHealthIssue> heatHealthIssues = [
     HeatHealthIssue(
      name: 'হিট এক্সহস্টশন',
      cause: 'দীর্ঘ সময় গরমে থাকা ও পর্যাপ্ত পানি না খাওয়া',
      symptom: 'দুর্বলতা, মাথা ঘোরা, বমি বমি ভাব, ঠাণ্ডা, পিলপিলে ত্বক, দ্রুত ও দুর্বল পালস',
      imageAsset: 'assets/images/heat_exhaustion.png',
    ),
    HeatHealthIssue(
      name: 'হিট স্ট্রোক',
      cause: 'শরীরের তাপমাত্রা দ্রুত বেড়ে যাওয়া ও ঘাম না হওয়া',
      symptom: 'ত্বক গরম ও শুষ্ক হওয়া, জ্ঞান হারানো, দ্রুত হার্টবিট, উচ্চ তাপমাত্রা (৪০°C বা বেশি)',
      imageAsset: 'assets/images/heat_stroke.png',
    ),
    HeatHealthIssue(
      name: 'হিট ক্র্যাম্প',
      cause: 'গরমে অতিরিক্ত ঘাম ও লবণ-পানি ঘাটতি',
      symptom: 'পেশীতে আকস্মিক ব্যথা বা সংকোচন, ঘাম হওয়া',
      imageAsset: 'assets/images/heat_cramp.png',
    ),
    HeatHealthIssue(
      name: 'ডিহাইড্রেশন',
      cause: 'শরীর থেকে অতিরিক্ত পানি বের হয়ে যাওয়া',
      symptom: 'তৃষ্ণা, শুকনো মুখ, কম প্রস্রাব, দুর্বলতা, চোখ শুকনো ও ডুবে যাওয়া',
      imageAsset: 'assets/images/dehydration.png',
    ),
    HeatHealthIssue(
      name: 'ত্বকের সমস্যা',
      cause: 'গরমে ঘাম জমে ত্বকে সমস্যা সৃষ্টি',
      symptom: 'লালচে দাগ বা ফুসকুড়ি, ত্বকে জ্বালা বা চুলকানি',
      imageAsset: 'assets/images/skin_problem.png',
    ),
  ];

  // Helper method to build a health issue card
  Widget _buildHealthIssueCard(HeatHealthIssue issue) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.red[50],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                issue.imageAsset,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(
                      width: 64,
                      height: 64,
                      color: Colors.grey[300],
                      child: const Icon(
                          Icons.image_not_supported, color: Colors.grey),
                    ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    issue.name,
                    style: const TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.red),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('কারণ: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Expanded(child: Text(issue.cause)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('লক্ষণ: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Expanded(child: Text(issue.symptom)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
