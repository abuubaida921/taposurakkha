import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'heatwave_question_list_view.dart';
import 'model/heat_health_issue.dart';

class HeatwaveAnswerView extends StatelessWidget {
  const HeatwaveAnswerView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final HeatwaveQuestion q = ModalRoute.of(context)!.settings.arguments as HeatwaveQuestion;

    Widget answerWidget;
    if (q.question == loc.healthSymptomsQ) {
      // Special case: show health issues cards
      answerWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _localizedHeatHealthIssues(loc).map((issue) => _buildHealthIssueCard(issue, loc)).toList(),
      );
    } else {
      answerWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (q.answer != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(q.answer!, style: const TextStyle(fontSize: 16)),
            ),
          if (q.bulletPoints != null)
            ...q.bulletPoints!.map((b) => _buildBulletPoint(b)).toList(),
          if (q.extraWidget != null) q.extraWidget!,
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(q.question, style: TextStyle(color: q.color)),
        iconTheme: IconThemeData(color: q.color),
        backgroundColor: q.color.withOpacity(0.1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: answerWidget,
      ),
    );
  }

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

  Widget _buildHealthIssueCard(HeatHealthIssue issue, AppLocalizations loc) {
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


