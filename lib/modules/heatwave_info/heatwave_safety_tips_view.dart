import 'package:flutter/material.dart';

class HeatwaveSafetyTipsView extends StatelessWidget {
  const HeatwaveSafetyTipsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'তাপপ্রবাহ সতর্কতা', // Heatwave Safety Tips
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Heatwave Q&A Section
            _buildInfoCard(
              title: 'তাপপ্রবাহের সময় করণীয় ও সতর্কতা',
              icon: Icons.question_answer,
              color: Colors.teal,
              children: [
                // Q1
                const Text(
                  'Q1: তাপপ্রবাহের সময় সতর্কতা কী কী নেওয়া উচিত?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _buildQAnswer([
                  'পর্যাপ্ত পানি পান করুন',
                  'শরীরের যত্নে সতর্ক থাকুন',
                  'ছায়া বা জানালায় খুব বেশি সময় না কাটান',
                  'বিশেষত শিশু ও বৃদ্ধদের জন্য বাড়তি সতর্কতা নিন',
                ]),
                const SizedBox(height: 16),
                // Q2
                const Text(
                  'Q2: কী ধরনের মানুষের সতর্কতা নেওয়া উচিত?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _buildQGroup(
                  group: 'শিশুদের জন্য',
                  karon: 'তাপপ্রবাহে শিশুদের তাপমাত্রা দ্রুত বাড়তে পারে।',
                  lokkho: 'অস্বস্তি, ঘাম, দুর্বলতা, খিটখিটে ভাব।',
                  chobi: 'assets/images/child.png',
                  tips: [
                    'সূর্যের সরাসরি আলো এড়িয়ে চলুন',
                    'হালকা, ঢিলেঢালা পোশাক পরান',
                    'পর্যাপ্ত পানি ও তরল খাবার দিন',
                    'গরম সময় বাইরে না যাওয়ার চেষ্টা করুন',
                  ],
                ),
                _buildQGroup(
                  group: 'বয়স্কদের জন্য',
                  karon: 'বয়স্কদের শরীরের তাপ নিয়ন্ত্রণ কম কার্যকর।',
                  lokkho: 'বমি, মাথা ঘোরা, দুর্বলতা, দ্রুত ক্লান্তি।',
                  chobi: 'assets/images/elderly.png',
                  tips: [
                    'গরম সময় বাইরে না থাকার পরামর্শ',
                    'ফ্যান বা কুলার ব্যবহার করুন',
                    'পর্যাপ্ত পানি পান নিশ্চিত করুন',
                  ],
                ),
                _buildQGroup(
                  group: 'তরুণদের জন্য',
                  karon: 'বাইরের কাজ বা কসরত বেশি হয়।',
                  lokkho: 'ঘাম, ক্লান্তি, মাথা ব্যথা।',
                  chobi: 'assets/images/young.png',
                  tips: [
                    'বাইরের কাজের সময় বিশ্রাম নিন',
                    'ছাতা বা ক্যাপ ব্যবহার করুন',
                    'পর্যাপ্ত পানি পান করুন',
                  ],
                ),
                _buildQGroup(
                  group: 'গর্ভবতী নারীদের জন্য',
                  karon: 'তাপপ্রবাহে গর্ভবতী নারীদের ঝুঁকি বেশি।',
                  lokkho: 'বমি, মাথা ঘোরা, ক্লান্তি।',
                  chobi: 'assets/images/pregnant.png',
                  tips: [
                    'গরম সময় বাইরে না থাকার চেষ্টা করুন',
                    'ঠান্ডা পানীয় পান করুন',
                    'হালকা পোশাক পরুন',
                  ],
                ),
                _buildQGroup(
                  group: 'বাইরের শ্রমিকদের জন্য',
                  karon: 'সূর্যের নিচে কাজ করতে হয়।',
                  lokkho: 'ঘাম, ক্লান্তি, মাথা ঘোরা।',
                  chobi: 'assets/images/worker.png',
                  tips: [
                    'পর্যাপ্ত বিশ্রাম নিন',
                    'পানি ও ইলেক্ট্রোলাইট পান করুন',
                    'ছায়ায় কাজ করুন',
                  ],
                ),
                _buildQGroup(
                  group: 'অসুস্থ বা দীর্ঘমেয়াদী রোগীদের জন্য',
                  karon: 'তাপপ্রবাহে অসুস্থদের ঝুঁকি বেশি।',
                  lokkho: 'দুর্বলতা, শ্বাসকষ্ট, মাথা ঘোরা।',
                  chobi: 'assets/images/sick.png',
                  tips: [
                    'গরম সময় বাইরে না যাওয়ার চেষ্টা করুন',
                    'পর্যাপ্ত পানি পান করুন',
                    'ডাক্তারের পরামর্শ নিন',
                  ],
                ),
                const SizedBox(height: 16),
                // Q3
                const Text(
                  'Q3: তাপপ্রবাহের সময় কীভাবে শরীর ঠান্ডা রাখা যায়?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _buildQAnswer([
                  'ছায়ায় থাকুন এবং ঠান্ডা পরিবেশে বিশ্রাম নিন',
                  'ঠান্ডা পানি পান করুন এবং হালকা কাপড় পরুন',
                  'হাত ও মুখ ঠান্ডা পানি দিয়ে ধুয়ে নিন',
                ]),
                const SizedBox(height: 16),
                // Q4
                const Text(
                  'Q4: বাড়ি ঠান্ডা রাখার উপায় কী?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _buildQAnswer([
                  'জানালা ও দরজা বন্ধ রাখুন',
                  'হালকা পর্দা ব্যবহার করুন',
                  'ফ্যান ব্যবহার করুন',
                ]),
                const SizedBox(height: 16),
                // Q5
                const Text(
                  'Q5: খাবারের পরামর্শ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _buildQAnswer([
                  'তরল ও সহজপাচ্য খাবার খান',
                  'ভাজা ও ভারী খাবার এড়িয়ে চলুন',
                  'ফলমূল ও শাকসবজি বেশি খান',
                  'পর্যাপ্ত প্রোটিন ও মিনারেল যুক্ত খাবার খান',
                ]),
                const SizedBox(height: 8),
                // Special info (italic, no bullet)
                const Text(
                  'বিশেষ তথ্য: গ্রীষ্মকালে পর্যাপ্ত পানি পান ও হালকা খাবার খাওয়া অত্যন্ত জরুরি।',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15, color: Colors.deepOrange),
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

  // Helper for Q&A answers
  Widget _buildQAnswer(List<String> answers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: answers.map((ans) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('• ', style: TextStyle(fontSize: 16)),
            Expanded(child: Text(ans, style: const TextStyle(fontSize: 16))),
          ],
        ),
      )).toList(),
    );
  }

  // Helper for Q&A group (with কারণ, লক্ষণ, ছবি)
  Widget _buildQGroup({
    required String group,
    required String karon,
    required String lokkho,
    required String chobi,
    required List<String> tips,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey[50],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(group, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.teal)),
            const SizedBox(height: 4),
            Text('কারণ: $karon', style: const TextStyle(fontWeight: FontWeight.w500)),
            Text('লক্ষণ: $lokkho', style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ছবি: ', style: TextStyle(fontWeight: FontWeight.w500)),
                Flexible(
                  child: Image.asset(
                    chobi,
                    width: 32,
                    height: 32,
                    fit: BoxFit.contain,
                    errorBuilder: (c, e, s) => const Icon(Icons.image_not_supported),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            ...tips.map((tip) => Row(
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