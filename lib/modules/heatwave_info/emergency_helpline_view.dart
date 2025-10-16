import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/app_localizations.dart';

class EmergencyHelplineView extends StatelessWidget {
  const EmergencyHelplineView({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a modern color scheme
    const Color primaryColor = Color(0xFFE53935); // A professional red
    const Color accentColor = Color(0xFFFBE9E7); // Light accent for background
    const Color textColor = Color(0xFF212121);
    const Color secondaryTextColor = Color(0xFF757575);

    // Local helper: sanitize phone number (keep digits and +)
    String sanitizeNumber(String raw) => raw.replaceAll(RegExp(r'[^+0-9]'), '');

    // Local helper: launch dialer
    Future<void> _launchPhone(BuildContext ctx, String rawNumber) async {
      final number = sanitizeNumber(rawNumber);
      if (number.isEmpty) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(content: Text('No valid phone number available')),
        );
        return;
      }

      final uri = Uri(scheme: 'tel', path: number);
      try {
        if (!await launchUrl(uri)) {
          ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(content: Text('Could not open dialer')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(content: Text('Could not open dialer')),
        );
      }
    }

    // Local helper: copy to clipboard with feedback
    void _copyNumber(BuildContext ctx, String rawNumber) {
      final number = sanitizeNumber(rawNumber);
      if (number.isEmpty) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(content: Text('No valid phone number to copy')),
        );
        return;
      }
      Clipboard.setData(ClipboardData(text: number));
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('Copied $number')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.emergencyHelplineTitle,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
              title: AppLocalizations.of(context)!.emergencyHelplineQuestion,
              // subtitle: AppLocalizations.of(context)!.emergencyHelplineQuestionSubtitle,
              content: AppLocalizations.of(context)!.emergencyHelplineQuestionContent,
              icon: Icons.question_answer_outlined,
              primaryColor: primaryColor,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
            ),
            const SizedBox(height: 16),
            // Professional Card for Services
            _buildServicesCard(
              context: context,
              title: AppLocalizations.of(context)!.emergencyHelplineServicesTitle,
              icon: Icons.local_hospital_outlined,
              items: [
                _ServiceItem(
                  title: 'Emergency Helpline',
                  subtitle: '999',
                  icon: Icons.phone_in_talk_outlined,
                ),
                _ServiceItem(
                  title: 'Health-Service Helpline (24-hour doctor advice)',
                  subtitle: '16263',
                  icon: Icons.local_hospital,
                ),
                _ServiceItem(
                  title: 'Ambulance Service',
                  subtitle: 'Contact',
                  icon: Icons.local_shipping,
                ),
                _ServiceItem(
                  title: '24h ambulance service',
                  subtitle: '01911125156',
                  icon: Icons.local_hospital,
                ),
                _ServiceItem(
                  title: 'Health X BD',
                  subtitle: '01969-908181',
                  icon: Icons.health_and_safety,
                ),
                _ServiceItem(
                  title: 'Doctors Support Centre',
                  subtitle: '01818-031380',
                  icon: Icons.support_agent,
                ),
                _ServiceItem(
                  title: 'Alo clinic, Korail',
                  subtitle: '01322-905355',
                  icon: Icons.local_hospital_rounded,
                ),
              ],
              primaryColor: primaryColor,
              textColor: textColor,
              secondaryTextColor: secondaryTextColor,
              onTapPhone: _launchPhone,
              onCopy: _copyNumber,
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
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<_ServiceItem> items,
    required Color primaryColor,
    required Color textColor,
    required Color secondaryTextColor,
    required Future<void> Function(BuildContext, String) onTapPhone,
    required void Function(BuildContext, String) onCopy,
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
                          item.title,
                          style: TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            // tappable number (if valid)
                            GestureDetector(
                              onTap: () {
                                if (item.subtitle.toLowerCase() != 'contact') {
                                  onTapPhone(context, item.subtitle);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Contact details not available')),
                                  );
                                }
                              },
                              child: Text(
                                item.subtitle,
                                style: TextStyle(fontSize: 14, color: secondaryTextColor, decoration: item.subtitle.toLowerCase() != 'contact' ? TextDecoration.underline : TextDecoration.none),
                              ),
                            ),

                            const SizedBox(width: 12),

                            // copy button
                            IconButton(
                              icon: const Icon(Icons.copy, size: 18),
                              color: primaryColor,
                              tooltip: 'Copy',
                              onPressed: () => onCopy(context, item.subtitle),
                            ),

                            // call button (visible only when number is not 'Contact')
                            if (item.subtitle.toLowerCase() != 'contact')
                              IconButton(
                                icon: const Icon(Icons.call, size: 18),
                                color: primaryColor,
                                tooltip: 'Call',
                                onPressed: () => onTapPhone(context, item.subtitle),
                              ),

                          ],
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