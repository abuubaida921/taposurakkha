import 'package:flutter/material.dart';

class WeatherDetailsBottomSheet extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? iconUrl;
  final String? iconAsset;
  final String temp;
  final String? feelsLike;
  final String humidity;
  final String? wind;
  final String? cloud;
  final String? minTemp;
  final String? maxTemp;
  final String? range;
  final String? lastUpdated;
  final List<Widget>? extraRows;

  const WeatherDetailsBottomSheet({
    super.key,
    required this.title,
    this.subtitle,
    this.iconUrl,
    this.iconAsset,
    required this.temp,
    this.feelsLike,
    required this.humidity,
    this.wind,
    this.cloud,
    this.minTemp,
    this.maxTemp,
    this.range,
    this.lastUpdated,
    this.extraRows,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.35,
      maxChildSize: 0.85,
      expand: false,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 16,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
              child: ListView(
                controller: scrollController,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 18),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (iconUrl != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            iconUrl!,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                        )
                      else if (iconAsset != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            iconAsset!,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                          if (subtitle != null)
                            Text(subtitle!, style: const TextStyle(fontSize: 15, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  _detailRow('Temperature', temp, Icons.thermostat, Colors.orange),
                  if (feelsLike != null)
                    _detailRow('Feels Like', feelsLike!, Icons.device_thermostat, Colors.deepOrange),
                  if (minTemp != null && maxTemp != null)
                    _detailRow('Min/Max', '$minTemp / $maxTemp', Icons.thermostat_auto, Colors.purple),
                  _detailRow('Humidity', humidity, Icons.water_drop, Colors.blue),
                  if (wind != null)
                    _detailRow('Wind', wind!, Icons.air, Colors.teal),
                  if (cloud != null)
                    _detailRow('Cloud', cloud!, Icons.cloud, Colors.grey),
                  if (range != null)
                    _detailRow('Range', range!, Icons.straighten, Colors.green),
                  if (extraRows != null) ...extraRows!,
                  const SizedBox(height: 8),
                  if (lastUpdated != null)
                    Text('Last updated: $lastUpdated', style: const TextStyle(fontSize: 13, color: Colors.grey)),
                ],
              ),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: IconButton(
                icon: const Icon(Icons.close_rounded, size: 28, color: Colors.grey),
                onPressed: () => Navigator.pop(context),
                tooltip: 'Close',
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _detailRow(String label, String value, IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}

