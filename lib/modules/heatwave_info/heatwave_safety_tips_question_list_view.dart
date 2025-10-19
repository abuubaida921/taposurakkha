
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'heatwave_safety_tip_question_model.dart';

class HeatwaveSafetyTipsQuestionListView extends StatelessWidget {
  const HeatwaveSafetyTipsQuestionListView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final questions = [
      HeatwaveSafetyTipQuestion(
        question: 'তাপপ্রবাহের সময় সতর্কতা কী কী নেওয়া উচিত?',
        bulletPoints: [
          loc.drinkPlentyOfWater,
          loc.takeCareOfBody,
          loc.avoidDirectSunlight,
          loc.extraCautionForChildrenAndElderly,
        ],
        icon: Icons.warning_amber_rounded,
        color: Colors.teal,
      ),
      HeatwaveSafetyTipQuestion(
        question: 'কী ধরনের মানুষের সতর্কতা নেওয়া উচিত?',
        groups: [
          HeatwaveSafetyTipGroup(
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
          HeatwaveSafetyTipGroup(
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
          HeatwaveSafetyTipGroup(
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
          HeatwaveSafetyTipGroup(
            group: loc.forPregnantWomen,
            karon: loc.pregnantHeatRisk,
            lokkho: loc.pregnantSymptoms,
            chobi: 'assets/images/pregnant_woman.png',
            tips: [
              loc.avoidGoingOutInHeat,
              loc.drinkColdBeverages,
              loc.wearLightClothing,
            ],
          ),
          HeatwaveSafetyTipGroup(
            group: loc.forOutdoorWorkers,
            karon: loc.outdoorWorkersRisk,
            lokkho: loc.outdoorWorkersSymptoms,
            chobi: 'assets/images/outdoor_worker.png',
            tips: [
              loc.takeAdequateRest,
              loc.drinkWaterAndElectrolytes,
              loc.workInShade,
            ],
          ),
          HeatwaveSafetyTipGroup(
            group: loc.forSickOrChronicPatients,
            karon: loc.sickHeatRisk,
            lokkho: loc.sickSymptoms,
            chobi: 'assets/images/ill_people.png',
            tips: [
              loc.avoidGoingOutInHeat,
              loc.drinkPlentyOfWater,
              loc.consultDoctor,
            ],
          ),
        ],
        icon: Icons.groups_2_rounded,
        color: Colors.deepPurple,
      ),
      HeatwaveSafetyTipQuestion(
        question: 'তাপপ্রবাহের সময় কীভাবে শরীর ঠান্ডা রাখা যায়?',
        bulletPoints: [
          loc.stayInShadeAndRestInCoolPlace,
          loc.drinkColdWaterAndWearLightClothes,
          loc.washHandsAndFaceWithColdWater,
        ],
        icon: Icons.ac_unit_rounded,
        color: Colors.blue,
      ),
      HeatwaveSafetyTipQuestion(
        question: 'বাড়ি ঠান্ডা রাখার উপায় কী?',
        bulletPoints: [
          loc.keepWindowsAndDoorsClosed,
          loc.useLightCurtains,
          loc.useFan,
        ],
        icon: Icons.home_rounded,
        color: Colors.green,
      ),
      HeatwaveSafetyTipQuestion(
        question: 'খাবারের পরামর্শ',
        bulletPoints: [
          loc.eatLiquidAndEasilyDigestibleFoods,
          loc.avoidFriedAndHeavyFoods,
          loc.eatMoreFruitsAndVegetables,
          loc.consumeAdequateProteinAndMinerals,
        ],
        specialInfo: 'বিশেষ তথ্য: গ্রীষ্মকালে পর্যাপ্ত পানি পান ও হালকা খাবার খাওয়া অত্যন্ত জরুরি।',
        icon: Icons.restaurant_rounded,
        color: Colors.orange,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.heatwaveSafety, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: questions.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final q = questions[index];
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(q.icon, color: q.color, size: 28),
              title: Text(q.question, style: TextStyle(fontWeight: FontWeight.bold, color: q.color)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/heatwave_safety_tip_answer',
                  arguments: q,
                );
              },
            ),
          );
        },
      ),
    );
  }
}