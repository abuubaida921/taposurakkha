
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'heat_alert_section_model.dart';

class HeatAlertSectionListView extends StatelessWidget {
  const HeatAlertSectionListView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final sections = [
      HeatAlertSection(
        title: loc.heatAlertImportanceTitle,
        icon: Icons.lightbulb_outline,
        color: Colors.blue,
        type: HeatAlertSectionType.importance,
      ),
      HeatAlertSection(
        title: loc.heatAlert7DayForecastTitle,
        icon: Icons.access_time,
        color: Colors.orange,
        type: HeatAlertSectionType.forecast,
      ),
      HeatAlertSection(
        title: loc.heatAlertWarningLevelsTitle,
        icon: Icons.notifications_active_outlined,
        color: Colors.red,
        type: HeatAlertSectionType.warningLevels,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.heatAlertTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: sections.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final s = sections[index];
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(s.icon, color: s.color, size: 28),
              title: Text(s.title, style: TextStyle(fontWeight: FontWeight.bold, color: s.color)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/heat_alert_section_detail',
                  arguments: s,
                );
              },
            ),
          );
        },
      ),
    );
  }
}