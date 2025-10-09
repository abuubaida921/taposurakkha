import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class HeatwaveQuestionListView extends StatelessWidget {
  const HeatwaveQuestionListView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final questions = [
      HeatwaveQuestion(
        question: loc.whatIsHeatwaveQ,
        answer: loc.whatIsHeatwaveA,
        icon: Icons.thermostat_outlined,
        color: Colors.blue,
      ),
      HeatwaveQuestion(
        question: loc.typesOfHeatwaveQ,
        bulletPoints: [
          loc.mildHeatwave,
          loc.moderateHeatwave,
          loc.severeHeatwave,
        ],
        icon: Icons.stacked_bar_chart,
        color: Colors.green,
      ),
      HeatwaveQuestion(
        question: loc.causesOfHeatwaveQ,
        bulletPoints: [
          loc.causeHighPressure,
          loc.causeDryWind,
          loc.causeUrbanHeatIsland,
          loc.causeClimateChange,
        ],
        icon: Icons.whatshot_outlined,
        color: Colors.orange,
        extraWidget: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Builder(
            builder: (context) {
              final loc = AppLocalizations.of(context)!;
              return RichText(
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
              );
            },
          ),
        ),
      ),
      HeatwaveQuestion(
        question: loc.healthSymptomsQ,
        icon: Icons.sick_outlined,
        color: Colors.red,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.heatwaveInfoTitle,
            style: const TextStyle(fontWeight: FontWeight.bold)),
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
                  '/heatwave_answer',
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


class HeatwaveQuestion {
  final String question;
  final String? answer;
  final List<String>? bulletPoints;
  final IconData icon;
  final Color color;
  final Widget? extraWidget;

  HeatwaveQuestion({
    required this.question,
    this.answer,
    this.bulletPoints,
    required this.icon,
    required this.color,
    this.extraWidget,
  });
}