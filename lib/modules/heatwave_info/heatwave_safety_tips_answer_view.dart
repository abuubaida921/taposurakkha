import 'package:flutter/material.dart';
import 'heatwave_safety_tip_question_model.dart';

class HeatwaveSafetyTipsAnswerView extends StatelessWidget {
  const HeatwaveSafetyTipsAnswerView({super.key});

  @override
  Widget build(BuildContext context) {
    final HeatwaveSafetyTipQuestion q = ModalRoute.of(context)!.settings.arguments as HeatwaveSafetyTipQuestion;

    return Scaffold(
      appBar: AppBar(
        title: Text(q.question, style: TextStyle(color: q.color)),
        iconTheme: IconThemeData(color: q.color),
        backgroundColor: q.color.withAlpha(25),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (q.bulletPoints != null)
              ...q.bulletPoints!.map((b) => _buildBulletPoint(b)).toList(),
            if (q.groups != null)
              ...q.groups!.map((g) => _buildQGroup(g)).toList(),
            if (q.specialInfo != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(q.specialInfo!, style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 15, color: Colors.deepOrange)),
              ),
          ],
        ),
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

  Widget _buildQGroup(HeatwaveSafetyTipGroup group) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey[50],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(group.group, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.teal)),
            const SizedBox(height: 4),
            Text('কারণ: ${group.karon}', style: const TextStyle(fontWeight: FontWeight.w500)),
            Text('লক্ষণ: ${group.lokkho}', style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ছবি: ', style: TextStyle(fontWeight: FontWeight.w500)),
                Flexible(
                  child: Image.asset(
                    group.chobi,
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                    errorBuilder: (c, e, s) => const Icon(Icons.image_not_supported),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            ...group.tips.map((tip) => Row(
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
