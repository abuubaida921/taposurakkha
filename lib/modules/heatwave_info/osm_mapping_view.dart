import 'package:flutter/material.dart';

class OsmMappingView extends StatelessWidget {
  const OsmMappingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ওএসএম ম্যাপিং', // OSM Mapping
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Safe Shelters Card
            _buildInfoCard(
              title: 'তাপপ্রবাহের সময় নিরাপদ আশ্রয়ের স্থান কোথায়?', // Where Can You Find Safe Shelters?
              icon: Icons.search,
              color: Colors.blue,
              children: const [
                Text(
                  'অফিস, হাসপাতাল, স্বাস্থ্য সহায়তা কেন্দ্র বা স্থানীয় সেবা প্রদানকারী স্থানগুলোর মানচিত্র দেখুন। আশেপাশে পানির উৎসের অবস্থানও জানা জরুরি।',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Map Content Card
            _buildInfoCard(
              title: 'স্থানীয় সেবা প্রদানকারীদের মানচিত্র', // Map of Local Service Providers
              icon: Icons.map_outlined,
              color: Colors.green,
              children: [
                _buildBulletPoint('তাপপ্রবাহের সময় নিরাপদ আশ্রয়ের স্থান এবং স্থানীয় সেবা প্রদানকারীদের মানচিত্র'),
                _buildBulletPoint('আশেপাশের পানির উৎসের অবস্থান'),
                _buildBulletPoint('হাসপাতাল, ক্লিনিক এবং স্বাস্থ্য সহায়তা কেন্দ্রের মানচিত্র'),
                _buildBulletPoint('জরুরি অবস্থায় সহায়তার জন্য তাপপ্রবাহের সময় দ্রুত পেতে সহায়ক মানচিত্র'),
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