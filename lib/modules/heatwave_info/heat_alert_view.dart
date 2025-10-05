import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class HeatAlertView extends StatelessWidget {
  const HeatAlertView({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          local.heatAlertTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Importance of Forecast Section
            _buildInfoCard(
              title: local.heatAlertImportanceTitle,
              icon: Icons.lightbulb_outline,
              color: Colors.blue,
              children: [
                _buildBulletPoint(local.heatAlertImportancePoint1),
                _buildBulletPoint(local.heatAlertImportancePoint2),
                _buildBulletPoint(local.heatAlertImportancePoint3),
              ],
            ),
            const SizedBox(height: 16),
            // 7-Day Forecast Section
            _buildInfoCard(
              title: local.heatAlert7DayForecastTitle,
              icon: Icons.access_time,
              color: Colors.orange,
              children: [
                Text(
                  local.heatAlertTemperatureChart,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _buildTemperatureRow(
                  level: local.heatAlertLevelWarning,
                  tempRange: local.heatAlertLevelWarningRange,
                  description: local.heatAlertLevelWarningDesc,
                  color: Colors.green,
                ),
                _buildTemperatureRow(
                  level: local.heatAlertLevelRisk,
                  tempRange: local.heatAlertLevelRiskRange,
                  description: local.heatAlertLevelRiskDesc,
                  color: Colors.yellow[800]!,
                ),
                _buildTemperatureRow(
                  level: local.heatAlertLevelAlert,
                  tempRange: local.heatAlertLevelAlertRange,
                  description: local.heatAlertLevelAlertDesc,
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Warning Levels Section
            _buildInfoCard(
              title: local.heatAlertWarningLevelsTitle,
              icon: Icons.notifications_active_outlined,
              color: Colors.red,
              children: [
                _buildWarningLevelRow(
                  color: Colors.red,
                  text: local.heatAlertWarningLevelRed,
                ),
                _buildWarningLevelRow(
                  color: Colors.yellow,
                  text: local.heatAlertWarningLevelYellow,
                ),
                _buildWarningLevelRow(
                  color: Colors.green,
                  text: local.heatAlertWarningLevelGreen,
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
}