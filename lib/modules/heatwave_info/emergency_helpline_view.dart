import 'package:flutter/material.dart';

class EmergencyHelplineView extends StatelessWidget {
  const EmergencyHelplineView({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a modern color scheme
    const Color primaryColor = Color(0xFFE53935); // A professional red
    const Color accentColor = Color(0xFFFBE9E7); // Light accent for background
    const Color textColor = Color(0xFF212121);
    const Color secondaryTextColor = Color(0xFF757575);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'জরুরি হেল্পলাইন',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: accentColor,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Professional Card for FAQ
            _buildInfoCard(
              title: 'জরুরি হেল্পলাইন নম্বর কী?',
              subtitle: '(What is the Emergency Helpline Number?)',
              content:
              'তাপপ্রবাহজনিত রোগের জন্য স্থানীয় স্বাস্থ্য বিভাগ ও অ্যাম্বুলেন্স সেবা নম্বর সংগ্রহ করুন।',
              icon: Icons.question_answer_outlined,
              primaryColor: primaryColor,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
            ),
            const SizedBox(height: 16),
            // Professional Card for Services
            _buildServicesCard(
              title: 'জরুরি পরিষেবা',
              icon: Icons.local_hospital_outlined,
              items: [
                _ServiceItem(
                  title: 'তাপপ্রবাহজনিত রোগের জন্য দ্রুত সহায়তা',
                  subtitle: '(Emergency assistance for heatwave-related illnesses)',
                  icon: Icons.phone_in_talk_outlined,
                ),
                _ServiceItem(
                  title: 'স্বাস্থ্য বিভাগের জরুরি সহায়তার জন্য স্থানীয় সংস্থা',
                  subtitle: '(Local organizations for emergency health assistance)',
                  icon: Icons.public_outlined,
                ),
                _ServiceItem(
                  title: 'অ্যাম্বুলেন্স সেবা এবং জরুরি চিকিৎসা পরিষেবা',
                  subtitle: '(Ambulance and emergency medical services)',
                  icon: Icons.phone_in_talk,
                ),
              ],
              primaryColor: primaryColor,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build an information card
  Widget _buildInfoCard({
    required String title,
    String? subtitle,
    required String content,
    required IconData icon,
    required Color primaryColor,
    required Color textColor,
    required Color secondaryTextColor,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: primaryColor, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 4),
                child: Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: secondaryTextColor),
                ),
              ),
            const SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(fontSize: 16, color: textColor),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a services card with a list of items
  Widget _buildServicesCard({
    required String title,
    required IconData icon,
    required List<_ServiceItem> items,
    required Color primaryColor,
    required Color textColor,
    required Color secondaryTextColor,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: primaryColor, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(item.icon, color: primaryColor, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• ${item.title}',
                          style: TextStyle(fontSize: 16, color: textColor),
                        ),
                        Text(
                          item.subtitle,
                          style: TextStyle(
                              fontSize: 14, color: secondaryTextColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

// A simple data class for service items
class _ServiceItem {
  final String title;
  final String subtitle;
  final IconData icon;

  const _ServiceItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}