import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app/localization_controller.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  static const _defaultUrl = 'https://example.com';

  @override
  Widget build(BuildContext context) {
    final LocalizationController lc = Get.find();
    final isBn = lc.locale.value.languageCode == 'bn';

    final shareMessage = isBn
        ? 'Taposurakkha অ্যাপ দেখুন — তাপপ্রবাহের সময় নিরাপদ থাকতে সহায়ক। ডাউনলোড করুন: $_defaultUrl'
        : 'Check out Taposurakkha — a helpful app for staying safe during heatwaves. Download: $_defaultUrl';

    final title = isBn ? 'তাপসুরক্ষা সম্পর্কে' : 'About Taposurakkha';

    final description = isBn
        ? 'Taposurakkha একটি জনগণমুখী মোবাইল অ্যাপ যা তাপপ্রবাহের সময় মানুষের নিরাপত্তা ও স্বাস্থ্য রক্ষা করার লক্ষ্যে তৈরি করা হয়েছে।'
        : 'Taposurakkha is a community-focused mobile app built to help protect people\'s health and safety during heatwaves.';

    final List<String> features = isBn
        ? [
            'আবহাওয়ার পূর্বাভাস এবং ৭ দিনের তাপমাত্রা তথ্য',
            'তাপপ্রবাহ সম্পর্কিত সতর্কতা ও নিরাপত্তা পরামর্শ',
            'নিকটস্থ স্বাস্থ্যসেবা কেন্দ্র, ক্লিনিক ও ফার্মেসি',
            'জরুরি যোগাযোগ নম্বর ও হেল্পলাইন',
            'লোকেশন-ভিত্তিক সার্ভিস এবং মানচিত্র',
          ]
        : [
            'Weather forecasts and 7-day temperature outlooks',
            'Heatwave alerts and practical safety tips',
            'Locations of nearby health centers, clinics and pharmacies',
            'Emergency helplines and important contact numbers',
            'Location-based services (maps of nearby pharmacies and providers)',
          ];

    final footer = isBn
        ? 'বিস্তারিত জানতে আমাদের ওয়েবসাইট দেখুন বা হেল্পলাইন ব্যবহার করুন।'
        : 'For more details visit our website or use the helpline contacts.';

    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.copy),
          //   tooltip: isBn ? 'লিংক কপি করুন' : 'Copy link',
          //   onPressed: () async {
          //     await Clipboard.setData(const ClipboardData(text: _defaultUrl));
          //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //       content: Text(isBn ? 'লিংক কপি হয়েছে' : 'Link copied'),
          //       duration: const Duration(seconds: 2),
          //     ));
          //   },
          // ),
          // IconButton(
          //   icon: const Icon(Icons.share),
          //   tooltip: isBn ? 'অ্যাপ শেয়ার করুন' : 'Share App',
          //   onPressed: () async {
          //     try {
          //       await SharePlus.instance.share(ShareParams(text: shareMessage));
          //     } catch (e) {
          //       await SharePlus.instance.share(ShareParams(text: shareMessage));
          //     }
          //   },
          // ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // App logo/avatar with semantics
                    Semantics(
                      label: isBn ? 'অ্যাপ লোগো' : 'App logo',
                      child: Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: primary.withAlpha((0.12 * 255).round()),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                            semanticLabel: title,
                            errorBuilder: (c, e, s) => Icon(Icons.local_fire_department, color: primary, size: 40),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(description, style: theme.textTheme.bodyMedium?.copyWith(height: 1.4)),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                const Divider(height: 1),
                const SizedBox(height: 12),

                // Feature list card with polished items
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(isBn ? 'বৈশিষ্ট্য' : 'Key features', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 12),

                        // Use ListTile-like rows for clearer hierarchy
                        ...features.map((f) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: primary.withAlpha((0.08 * 255).round()),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.check, color: primary, size: 18),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(child: Text(f, style: theme.textTheme.bodyMedium)),
                                ],
                              ),
                            )),

                        const SizedBox(height: 20),

                        // Responsive action buttons
                        Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () async {
                                try {
                                  await SharePlus.instance.share(ShareParams(text: shareMessage));
                                } catch (_) {
                                  await SharePlus.instance.share(ShareParams(text: shareMessage));
                                }
                              },
                              icon: const Icon(Icons.share_outlined),
                              label: Text(isBn ? 'শেয়ার করুন' : 'Share'),
                              style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                            ),

                            OutlinedButton.icon(
                              onPressed: () async {
                                final uri = Uri.parse(_defaultUrl);
                                if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isBn ? 'ওয়েবসাইট খোলা যায়নি' : 'Could not open website')));
                                }
                              },
                              icon: const Icon(Icons.open_in_browser),
                              label: Text(isBn ? 'ওয়েবসাইট দেখুন' : 'Visit website'),
                              style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                            ),

                            OutlinedButton.icon(
                              onPressed: () async {
                                await Clipboard.setData(const ClipboardData(text: _defaultUrl));
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isBn ? 'লিংক কপি হয়েছে' : 'Link copied')));
                              },
                              icon: const Icon(Icons.copy),
                              label: Text(isBn ? 'লিংক কপি করুন' : 'Copy link'),
                              style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                            ),

                            OutlinedButton.icon(
                              onPressed: () async {
                                // report / contact action using mailto
                                final email = Uri(
                                  scheme: 'mailto',
                                  path: 'support@example.com',
                                  queryParameters: {'subject': 'Taposurakkha app support'},
                                );
                                if (!await launchUrl(email)) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isBn ? 'ইমেইল পাঠানো যাচ্ছে না' : 'Could not open email client')));
                                }
                              },
                              icon: const Icon(Icons.email_outlined),
                              label: Text(isBn ? 'সাপোর্ট' : 'Contact'),
                              style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(footer, style: TextStyle(color: Colors.grey[600])),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('Version 1.0.0', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                ),
                const SizedBox(height: 24),

                Center(child: Text(isBn ? 'Made with ❤️ in Bangladesh' : 'Made with ❤️ in Bangladesh', style: TextStyle(color: Colors.grey[500], fontSize: 12))),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
