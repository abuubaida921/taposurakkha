import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/localization_controller.dart';
import '../../l10n/app_localizations.dart';

class HeatwaveSafetyTipsView extends StatelessWidget {
  const HeatwaveSafetyTipsView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final LocalizationController localizationController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.heatwaveSafety,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Heatwave Q&A Section
            _buildInfoCard(
              title: loc.heatwavePrecautions,
              icon: Icons.question_answer,
              color: Colors.teal,
              children: [
                // Q1
                const Text(
                  'Q1: তাপপ্রবাহের সময় সতর্কতা কী কী নেওয়া উচিত?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _buildQAnswer([
                  loc.drinkPlentyOfWater,
                  loc.takeCareOfBody,
                  loc.avoidDirectSunlight,
                  loc.extraCautionForChildrenAndElderly,
                ]),
                const SizedBox(height: 16),
                // Q2
                const Text(
                  'Q2: কী ধরনের মানুষের সতর্কতা নেওয়া উচিত?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _buildQGroup(
                  group: loc.forChildren,
                  karon: loc.childrenHeatRisk,
                  lokkho: loc.childrenSymptoms,
                  chobi: 'assets/images/child.png',
                  tips: [
                    loc.avoidDirectSunlight,
                    loc.wearLightLooseClothing,
                    loc.provideAdequateWaterAndFluids,
                    loc.avoidOutdoorActivitiesDuringHeat,
                  ],
                ),
                _buildQGroup(
                  group: loc.forElderly,
                  karon: loc.elderlyHeatRisk,
                  lokkho: loc.elderlySymptoms,
                  chobi: 'assets/images/elderly.png',
                  tips: [
                    loc.avoidGoingOutInHeat,
                    loc.useFanOrCooler,
                    loc.ensureAdequateWaterIntake,
                  ],
                ),
                _buildQGroup(
                  group: loc.forYouth,
                  karon: loc.youthOutdoorRisk,
                  lokkho: loc.youthSymptoms,
                  chobi: 'assets/images/young.png',
                  tips: [
                    loc.takeBreaksDuringOutdoorWork,
                    loc.useUmbrellaOrCap,
                    loc.drinkPlentyOfWater,
                  ],
                ),
                _buildQGroup(
                  group: loc.forPregnantWomen,
                  karon: loc.pregnantHeatRisk,
                  lokkho: loc.pregnantSymptoms,
                  chobi: 'assets/images/pregnant.png',
                  tips: [
                    loc.avoidGoingOutInHeat,
                    loc.drinkColdBeverages,
                    loc.wearLightClothing,
                  ],
                ),
                _buildQGroup(
                  group: loc.forOutdoorWorkers,
                  karon: loc.outdoorWorkersRisk,
                  lokkho: loc.outdoorWorkersSymptoms,
                  chobi: 'assets/images/worker.png',
                  tips: [
                    loc.takeAdequateRest,
                    loc.drinkWaterAndElectrolytes,
                    loc.workInShade,
                  ],
                ),
                _buildQGroup(
                  group: loc.forSickOrChronicPatients,
                  karon: loc.sickHeatRisk,
                  lokkho: loc.sickSymptoms,
                  chobi: 'assets/images/sick.png',
                  tips: [
                    loc.avoidGoingOutInHeat,
                    loc.drinkPlentyOfWater,
                    loc.consultDoctor,
                  ],
                ),
                const SizedBox(height: 16),
                // Q3
                const Text(
                  'Q3: তাপপ্রবাহের সময় কীভাবে শরীর ঠান্ডা রাখা যায়?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _buildQAnswer([
                  loc.stayInShadeAndRestInCoolPlace,
                  loc.drinkColdWaterAndWearLightClothes,
                  loc.washHandsAndFaceWithColdWater,
                ]),
                const SizedBox(height: 16),
                // Q4
                const Text(
                  'Q4: বাড়ি ঠান্ডা রাখার উপায় কী?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _buildQAnswer([
                  loc.keepWindowsAndDoorsClosed,
                  loc.useLightCurtains,
                  loc.useFan,
                ]),
                const SizedBox(height: 16),
                // Q5
                const Text(
                  'Q5: খাবারের পরামর্শ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _buildQAnswer([
                  loc.eatLiquidAndEasilyDigestibleFoods,
                  loc.avoidFriedAndHeavyFoods,
                  loc.eatMoreFruitsAndVegetables,
                  loc.consumeAdequateProteinAndMinerals,
                ]),
                const SizedBox(height: 8),
                // Special info (italic, no bullet)
                const Text(
                  'বিশেষ তথ্য: গ্রীষ্মকালে পর্যাপ্ত পানি পান ও হালকা খাবার খাওয়া অত্যন্ত জরুরি।',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15, color: Colors.deepOrange),
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
                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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

  // Helper for Q&A answers
  Widget _buildQAnswer(List<String> answers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: answers.map((ans) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('• ', style: TextStyle(fontSize: 16)),
            Expanded(child: Text(ans, style: const TextStyle(fontSize: 16))),
          ],
        ),
      )).toList(),
    );
  }

  // Helper for Q&A group (with কারণ, লক্ষণ, ছবি)
  Widget _buildQGroup({
    required String group,
    required String karon,
    required String lokkho,
    required String chobi,
    required List<String> tips,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey[50],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(group, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.teal)),
            const SizedBox(height: 4),
            Text('কারণ: $karon', style: const TextStyle(fontWeight: FontWeight.w500)),
            Text('লক্ষণ: $lokkho', style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ছবি: ', style: TextStyle(fontWeight: FontWeight.w500)),
                Flexible(
                  child: Image.asset(
                    chobi,
                    width: 32,
                    height: 32,
                    fit: BoxFit.contain,
                    errorBuilder: (c, e, s) => const Icon(Icons.image_not_supported),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            ...tips.map((tip) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(fontSize: 15)),
                Expanded(child: Text(tip, style: const TextStyle(fontSize: 15))),
              ],
            )),
          ],
        ),
      ),
    );
  }
}