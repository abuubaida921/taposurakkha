import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../app/localization_controller.dart';

class OsmMappingView extends StatelessWidget {
  const OsmMappingView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final LocalizationController localizationController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.osmMapping,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Q1 Card
            _buildInfoCard(
              title: loc.safeShelterQ,
              icon: Icons.search,
              color: Colors.blue,
              children: [
                Text(
                  loc.answerLabel,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 6),
                Text(
                  loc.safeShelterA,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 6),
                Text(
                  loc.seeMap,
                  style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 15, color: Colors.deepOrange),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Q2 Card
            _buildInfoCard(
              title: loc.serviceMapQ,
              icon: Icons.map_outlined,
              color: Colors.green,
              children: [
                _buildBulletPoint(loc.serviceMapA1),
                _buildBulletPoint(loc.serviceMapA2),
                _buildBulletPoint(loc.serviceMapA3),
                _buildBulletPoint(loc.serviceMapA4),
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
}