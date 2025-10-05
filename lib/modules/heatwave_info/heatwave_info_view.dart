import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../l10n/app_localizations.dart';

import 'model/heat_health_issue.dart';

class HeatwaveInfoView extends StatelessWidget {
   HeatwaveInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.heatwaveInfoTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Q1: What is a Heatwave?
            _buildInfoCard(
              title: loc.whatIsHeatwaveQ,
              // What is a Heatwave?
              answer: loc.whatIsHeatwaveA,
              // A heatwave is a period when the temperature becomes significantly higher than normal and lasts for at least 3 days. Usually, the temperature is 36°C or higher.
              icon: Icons.thermostat_outlined,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            // Q2: Types of Heatwaves in Bangladesh
            _buildInfoCard(
              title: loc.typesOfHeatwaveQ,
              // Types of Heatwaves in Bangladesh
              icon: Icons.stacked_bar_chart,
              color: Colors.green,
              children: [
                _buildBulletPoint(loc.mildHeatwave),
                _buildBulletPoint(loc.moderateHeatwave),
                _buildBulletPoint(loc.severeHeatwave),
              ],
            ),
            const SizedBox(height: 16),
            // Q3: Causes of Heatwaves
            _buildInfoCard(
              title: loc.causesOfHeatwaveQ,
              // What are the Causes of Heatwaves?
              icon: Icons.whatshot_outlined,
              color: Colors.orange,
              children: [
                _buildBulletPoint(loc.causeHighPressure),
                _buildBulletPoint(loc.causeDryWind),
                _buildBulletPoint(loc.causeUrbanHeatIsland),
                _buildBulletPoint(loc.causeClimateChange),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.deepOrange,
                      ),
                      children: [
                        TextSpan(
                          text: loc.preMonsoonLabel + ' ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: loc.preMonsoonSpecial,
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
                            loc.healthSymptomsQ,
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
                    ..._localizedHeatHealthIssues(loc).map((issue) => _buildHealthIssueCard(issue)).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<HeatHealthIssue> _localizedHeatHealthIssues(AppLocalizations loc) {
    return [
      HeatHealthIssue(
        name: loc.heatExhaustion,
        cause: loc.heatExhaustionCause,
        symptom: loc.heatExhaustionSymptom,
        imageAsset: 'assets/images/heat_exhaustion.png',
      ),
      HeatHealthIssue(
        name: loc.heatStroke,
        cause: loc.heatStrokeCause,
        symptom: loc.heatStrokeSymptom,
        imageAsset: 'assets/images/heat_stroke.png',
      ),
      HeatHealthIssue(
        name: loc.heatCramp,
        cause: loc.heatCrampCause,
        symptom: loc.heatCrampSymptom,
        imageAsset: 'assets/images/heat_cramp.png',
      ),
      HeatHealthIssue(
        name: loc.dehydration,
        cause: loc.dehydrationCause,
        symptom: loc.dehydrationSymptom,
        imageAsset: 'assets/images/dehydration.png',
      ),
      HeatHealthIssue(
        name: loc.skinProblem,
        cause: loc.skinProblemCause,
        symptom: loc.skinProblemSymptom,
        imageAsset: 'assets/images/skin_problem.png',
      ),
    ];
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
    final loc = AppLocalizations.of(Get.context!)!;
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
                       Text(loc.causeLabel,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Expanded(child: Text(issue.cause)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(loc.symptomLabel,
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
