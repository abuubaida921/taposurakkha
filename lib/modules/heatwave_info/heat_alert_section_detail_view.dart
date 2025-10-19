import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../l10n/app_localizations.dart';
import 'heat_alert_section_model.dart';

class HeatAlertSectionDetailView extends StatelessWidget {
  const HeatAlertSectionDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final HeatAlertSection section = ModalRoute.of(context)!.settings.arguments as HeatAlertSection;

    // prepare copyable text for the active section
    final String copyText = _sectionCopyText(loc, section);

    Widget content;
    switch (section.type) {
      case HeatAlertSectionType.importance:
        content = _buildImportanceSection(loc);
        break;
      case HeatAlertSectionType.forecast:
        content = _buildForecastSection(loc);
        break;
      case HeatAlertSectionType.warningLevels:
        content = _buildWarningLevelsSection(loc);
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(section.title, style: TextStyle(color: section.color)),
        iconTheme: IconThemeData(color: section.color),
        backgroundColor: section.color.withAlpha(25),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            tooltip: loc.localeName.startsWith('bn') ? 'কপি' : 'Copy',
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: copyText));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(loc.localeName.startsWith('bn') ? 'ক্লিপবোর্ডে কপি করা হয়েছে' : 'Copied to clipboard')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: content,
      ),
    );
  }

  String _sectionCopyText(AppLocalizations loc, HeatAlertSection section) {
    switch (section.type) {
      case HeatAlertSectionType.importance:
        return '${loc.heatAlertImportanceTitle}\n\n${loc.heatAlertImportancePoint1}\n${loc.heatAlertImportancePoint2}\n${loc.heatAlertImportancePoint3}';
      case HeatAlertSectionType.forecast:
        return '${loc.heatAlert7DayForecastTitle}\n\n${loc.heatAlertTemperatureChart}\n\n'
            '${loc.heatAlertLevelWarning}: ${loc.heatAlertLevelWarningRange}\n${loc.heatAlertLevelWarningDesc}\n\n'
            '${loc.heatAlertLevelRisk}: ${loc.heatAlertLevelRiskRange}\n${loc.heatAlertLevelRiskDesc}\n\n'
            '${loc.heatAlertLevelAlert}: ${loc.heatAlertLevelAlertRange}\n${loc.heatAlertLevelAlertDesc}';
      case HeatAlertSectionType.warningLevels:
        return '${loc.heatAlertWarningLevelsTitle}\n\n${loc.heatAlertWarningLevelRed}\n${loc.heatAlertWarningLevelYellow}\n${loc.heatAlertWarningLevelGreen}';
    }
  }

  Widget _buildImportanceSection(AppLocalizations loc) {
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
                Icon(Icons.lightbulb_outline, color: Colors.blue, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    loc.heatAlertImportanceTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildBulletPoint(loc.heatAlertImportancePoint1),
            _buildBulletPoint(loc.heatAlertImportancePoint2),
            _buildBulletPoint(loc.heatAlertImportancePoint3),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastSection(AppLocalizations loc) {
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
                Icon(Icons.access_time, color: Colors.orange, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    loc.heatAlert7DayForecastTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              loc.heatAlertTemperatureChart,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            _buildTemperatureRow(
              level: loc.heatAlertLevelWarning,
              tempRange: loc.heatAlertLevelWarningRange,
              description: loc.heatAlertLevelWarningDesc,
              color: Colors.green,
            ),
            _buildTemperatureRow(
              level: loc.heatAlertLevelRisk,
              tempRange: loc.heatAlertLevelRiskRange,
              description: loc.heatAlertLevelRiskDesc,
              color: Colors.yellow,
            ),
            _buildTemperatureRow(
              level: loc.heatAlertLevelAlert,
              tempRange: loc.heatAlertLevelAlertRange,
              description: loc.heatAlertLevelAlertDesc,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningLevelsSection(AppLocalizations loc) {
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
                Icon(Icons.notifications_active_outlined, color: Colors.red, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    loc.heatAlertWarningLevelsTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
            _buildWarningLevelRow(color: Colors.red, text: loc.heatAlertWarningLevelRed),
            _buildWarningLevelRow(color: Colors.yellow, text: loc.heatAlertWarningLevelYellow),
            _buildWarningLevelRow(color: Colors.green, text: loc.heatAlertWarningLevelGreen),
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
                  '$level: $tempRange',
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
