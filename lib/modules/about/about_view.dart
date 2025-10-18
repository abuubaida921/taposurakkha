import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get/get.dart';
import '../../l10n/app_localizations.dart';
import '../../app/localization_controller.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final LocalizationController lc = Get.find();
    final isBn = lc.locale.value.languageCode == 'bn';

    final shareTooltip = isBn ? 'অ্যাপ শেয়ার করুন' : 'Share App';
    final shareMessage = isBn
        ? 'Taposurakkha অ্যাপ দেখুন — তাপপ্রবাহের সময় নিরাপদ থাকতে সহায়ক। ডাউনলোড করুন: https://example.com'
        : 'Check out Taposurakkha — a helpful app for staying safe during heatwaves. Download: https://example.com';

    final title = isBn ? 'তাপসুরক্ষা সম্পর্কে' : 'About Taposurakkha';

    final longText = isBn
        ? '''Taposurakkha একটি জনগণমুখী মোবাইল অ্যাপ যা তাপপ্রবাহের সময় মানুষের নিরাপত্তা ও স্বাস্থ্য রক্ষা করার লক্ষ্যে তৈরি করা হয়েছে। অ্যাপটিতে নিম্নলিখিত সুবিধা রয়েছে:
+
+- আবহাওয়ার পূর্বাভাস এবং ৭ দিনের তাপমাত্রা তথ্য
+- তাপপ্রবাহ সম্পর্কিত সতর্কতা ও সতর্কতা মাপক নির্দেশিকা
+- নিকটস্থ স্বাস্থ্যসেবা কেন্দ্র, ক্লিনিক ও ফার্মেসির অবস্থান
+- জরুরি যোগাযোগ নম্বরসহ হেল্পলাইন তালিকা
+- লোকেশন-ভিত্তিক সার্ভিস (স্থানীয় ফার্মেসি ও সেবা প্রদানকারীদের মানচিত্র)
+
+অ্যাপটির উদ্দেশ্য হচ্ছে জনগণকে দ্রুত তথ্য ও সাহায্য পৌঁছে দেয়া, যাতে গরমে সৃষ্ট স্বাস্থ্যঝুঁকি কমানো যায়। আমরা ভবিষ্যতে আরও ফিচার যোগ করার পরিকল্পনা করছি, যেমন—স্থানীয় সহায়তা শেয়ারিং, কেস-নোট, এবং সম্প্রদায়ভিত্তিক সতর্কতা।'''
        : '''Taposurakkha is a community-focused mobile app built to help protect people's health and safety during heatwaves. Key features include:
+
+- Weather forecasts and 7-day temperature outlooks
+- Heatwave alerts and practical safety tips
+- Locations of nearby health centers, clinics and pharmacies
+- Emergency helplines and important contact numbers
+- Location-based services (maps of nearby pharmacies and service providers)
+
+The goal is to deliver timely information and access to help so heat-related risks can be reduced. We plan to add more features such as local assistance sharing, case notes, and community alerts in future updates.''';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: shareTooltip,
            onPressed: () async {
              // Use the SharePlus API via Share.share (backwards compatible) or SharePlus.instance
              try {
                await Share.share(shareMessage);
              } catch (e) {
                // fallback
                Share.share(shareMessage);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              // Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(longText, style: const TextStyle(fontSize: 16), textAlign: TextAlign.start),
              const SizedBox(height: 20),
              // Optional: provide a small 'Contact / Source' footer
              Text(isBn ? 'বিস্তারিত জানতে আমাদের ওয়েবসাইট দেখুন বা হেল্পলাইন ব্যবহার করুন।' : 'For more details visit our website or use the helpline contacts.', style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
