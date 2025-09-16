import 'package:flutter/material.dart';

class HeatwaveInfoView extends StatelessWidget {
  const HeatwaveInfoView({super.key});

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
              title: 'তাপপ্রবাহ কী?', // What is a Heatwave?
              answer: 'তাপপ্রবাহ হলো একটি সময়কাল, যখন তাপমাত্রা স্বাভাবিকের চেয়ে উল্লেখযোগ্যভাবে বেশি হয়ে যায় এবং এটি কমপক্ষে ৩ দিন ধরে স্থায়ী হয়। সাধারণত, তাপমাত্রা ৩৬°C বা তার বেশি হয়ে থাকে।', // A heatwave is a period when the temperature becomes significantly higher than normal and lasts for at least 3 days. Usually, the temperature is 36°C or higher.
              icon: Icons.thermostat_outlined,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            // Q2: Types of Heatwaves in Bangladesh
            _buildInfoCard(
              title: 'বাংলাদেশে তাপপ্রবাহের প্রকারভেদ', // Types of Heatwaves in Bangladesh
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
              title: 'তাপপ্রবাহের কারণ কী?', // What are the Causes of Heatwaves?
              icon: Icons.whatshot_outlined,
              color: Colors.orange,
              children: [
                _buildBulletPoint('উচ্চচাপ বায়ুমণ্ডলীয় অবস্থা, ফলে গরম বাতাস জমে থাকা'),
                _buildBulletPoint('শুষ্ক মৌসুমি বায়ু প্রবাহ'),
                _buildBulletPoint('নগর এলাকায় তাপদ্বীপ প্রভাব (Urban Heat Island Effect)'),
                _buildBulletPoint('জলবায়ু পরিবর্তনের কারণে তাপমাত্রা বৃদ্ধি'),
                _buildBulletPoint('বর্ষার আগে গরমের সময় সূর্যের আলো খুব তীব্র হয়, মাটিতে আর্দ্রতা কম থাকে, আর গরম বাতাস ও শুকনো আবহাওয়া মিলে হিটওয়েভ তৈরি করে।'),
              ],
            ),
            const SizedBox(height: 16),
            // Q4: Symptoms of Heat-Related Health Issues
            _buildInfoCard(
              title: 'তাপপ্রবাহের সময় স্বাস্থ্যগত সংকটের লক্ষণ কী কী?', // What are the Symptoms of Heat-Related Health Issues?
              icon: Icons.sick_outlined,
              color: Colors.red,
              children: [
                _buildSymptomPoint(
                  symptom: 'হিট এক্সহস্টশন',
                  description: 'দুর্বলতা, মাথা ঘোরা, বমি বমি ভাব, ঠাণ্ডা, পিলপিলে ত্বক, দ্রুত ও দুর্বল পালস',
                ),
                _buildSymptomPoint(
                  symptom: 'হিট স্ট্রোক',
                  description: 'ত্বক গরম ও শুষ্ক হওয়া, জ্ঞান হারানো, দ্রুত হার্টবিট, উচ্চ তাপমাত্রা (৪০°C বা বেশি)',
                ),
                _buildSymptomPoint(
                  symptom: 'হিট ক্র্যাম্প',
                  description: 'পেশীতে আকস্মিক ব্যথা বা সংকোচন, ঘাম হওয়া',
                ),
                _buildSymptomPoint(
                  symptom: 'ডিহাইড্রেশন',
                  description: 'তৃষ্ণা, শুকনো মুখ, কম প্রস্রাব, দুর্বলতা, চোখ শুকনো ও ডুবে যাওয়া',
                ),
                _buildSymptomPoint(
                  symptom: 'ত্বকের সমস্যা',
                  description: 'লালচে দাগ বা ফুসকুড়ি, ত্বকে জ্বালা বা চুলকানি',
                ),
              ],
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

  // Helper method for symptoms with descriptions
  Widget _buildSymptomPoint({
    required String symptom,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• $symptom:',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}