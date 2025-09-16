import 'package:flutter/material.dart';

class HeatAlertView extends StatelessWidget {
  const HeatAlertView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'হিট এলার্ট',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Importance of Forecast Section
            _buildInfoCard(
              title: 'তাপপ্রবাহের পূর্বাভাসের গুরুত্ব', // The Importance of Heatwave Forecast
              icon: Icons.lightbulb_outline,
              color: Colors.blue,
              children: [
                _buildBulletPoint('আগাম সতর্কতা দিয়ে স্বাস্থ্য সুরক্ষা ও পানি সংরক্ষণে সহায়তা'),
                _buildBulletPoint('কৃষি ও শিল্পক্ষেত্রে ক্ষতি কমানো'),
                _buildBulletPoint('জরুরি সেবা ও হাসপাতালের প্রস্তুতি গ্রহণ সহজ করা'),
              ],
            ),
            const SizedBox(height: 16),
            // 7-Day Forecast Section
            _buildInfoCard(
              title: 'আগামী ৭ দিনের পূর্বাভাস', // Forecast for the next 7 days
              icon: Icons.access_time,
              color: Colors.orange,
              children: [
                const Text(
                  'তাপমাত্রা সারণী', // Temperature Chart
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _buildTemperatureRow(
                  level: 'সতর্কতা', // Warning
                  tempRange: '৩৫°C - ৩৮°C',
                  description: 'গরম আবহাওয়ার কারণে শিশু, বৃদ্ধ এবং অসুস্থ মানুষদের বাইরে বের না হওয়ার পরামর্শ দেওয়া হবে।',
                  color: Colors.green,
                ),
                _buildTemperatureRow(
                  level: 'ঝুঁকি', // Risk
                  tempRange: '৩৯°C - ৪২°C',
                  description: 'পানির সংকট এবং তাপজনিত সমস্যাগুলি বৃদ্ধি পাবে। রোগী সেবা ও জরুরি চিকিৎসা প্রস্তুতির উপর গুরুত্ব দিতে হবে।',
                  color: Colors.yellow[800]!,
                ),
                _buildTemperatureRow(
                  level: 'হুঁশিয়ারি', // Alert
                  tempRange: '৪০°C বা তার বেশি',
                  description: 'তীব্র তাপপ্রবাহ, কৃষি ও জলসম্পদ ক্ষতিগ্রস্ত হতে পারে। সবার জন্য নিরাপদ আশ্রয়স্থলে থাকার পরামর্শ থাকবে।',
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Warning Levels Section
            _buildInfoCard(
              title: 'সতর্কতা স্তর', // Warning Levels
              icon: Icons.notifications_active_outlined,
              color: Colors.red,
              children: [
                _buildWarningLevelRow(
                  color: Colors.red,
                  text: 'লাল সংকেত: তীব্র তাপপ্রবাহ, দীর্ঘস্থায়ী গরম আবহাওয়া।',
                ),
                _buildWarningLevelRow(
                  color: Colors.yellow,
                  text: 'হলুদ সংকেত: মাঝারি তাপমাত্রা বৃদ্ধি, কিছু সতর্কতা প্রয়োজন।',
                ),
                _buildWarningLevelRow(
                  color: Colors.green,
                  text: 'সবুজ সংকেত: সাধারণ গরম, তেমন কোন বিশেষ সতর্কতার প্রয়োজন নেই।',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a card for a section
  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
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
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  // Helper method to build a temperature row
  Widget _buildTemperatureRow({
    required String level,
    required String tempRange,
    required String description,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${level}: ${tempRange}',
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
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

  // Helper method for warning levels with colored dots
  Widget _buildWarningLevelRow({required Color color, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}