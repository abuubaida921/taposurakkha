import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taposurakkha/app/routes.dart';
import 'package:taposurakkha/app/shared_preferences_helper.dart';
import 'package:taposurakkha/app/toast_helper.dart';
import '../../l10n/app_localizations.dart';
import '../../app/localization_controller.dart';
import 'weather_forecast_model.dart';
import 'weather_forecast_service.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  bool _loading = true;
  double? _temperature;
  final TextEditingController _tempController = TextEditingController();

  WeatherForecastResponse? _forecastResponse;
  bool _forecastLoading = true;
  String? _forecastError;

  @override
  void initState() {
    super.initState();
    _checkAuth();
    _fetchForecast();
  }

  Future<void> _checkAuth() async {
    setState(() {
      _loading = false;
    });
  }

  Future<void> _fetchForecast() async {
    setState(() {
      _forecastLoading = true;
      _forecastError = null;
    });
    try {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final res = await WeatherForecastService.fetchForecast(start: today);
      if (res != null && res.status == 'ok') {
        setState(() {
          _forecastResponse = res;
          _forecastLoading = false;
        });
      } else {
        setState(() {
          _forecastError = 'Failed to load forecast';
          _forecastLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _forecastError = 'Error: $e';
        _forecastLoading = false;
      });
    }
  }

  void _logout() async {
    await SharedPreferencesHelper.setIsAuthenticated(false);
    await SharedPreferencesHelper.setLoginResponse({});
    ToastHelper.showInfo('You have been logged out');
  }

  void _login() {
    Get.toNamed('/login');
  }

  @override
  void dispose() {
    _tempController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final LocalizationController localizationController = Get.find();
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text(loc.dashboardTitle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.appTitle),
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            onSelected: (locale) => localizationController.changeLocale(locale),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: LocalizationController.bangla,
                child: Text(loc.bangla),
              ),
              PopupMenuItem(
                value: LocalizationController.english,
                child: Text(loc.english),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Weather Forecast Section
              Text(loc.weatherForecast ?? 'Weather Forecast', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              if (_forecastLoading)
                const Center(child: CircularProgressIndicator())
              else if (_forecastError != null)
                Text(_forecastError!, style: const TextStyle(color: Colors.red))
              else if (_forecastResponse != null)
                _WeatherForecastList(forecast: _forecastResponse!.data.forecast),
              const SizedBox(height: 24),
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                children: [
                  _FeatureCard(
                    icon: Icons.info,
                    color: Colors.orange,
                    title: loc.heatwaveInfo ?? 'তাপপ্রবাহের ধারনা',
                    onTap: () => Get.toNamed(AppRoutes.heatwaveInfo),
                  ),
                  _FeatureCard(
                    icon: Icons.warning_amber,
                    color: Colors.redAccent,
                    title: loc.heatwaveSafety ?? 'তাপপ্রবাহ সতর্কতা',
                    onTap: () => Get.toNamed(AppRoutes.heatwaveSafetyTips),
                  ),
                  _FeatureCard(
                    icon: Icons.map,
                    color: Colors.blue,
                    title: loc.osmMapping,
                    onTap: () => Get.toNamed(AppRoutes.osmMapping),
                  ),
                  _FeatureCard(
                    icon: Icons.thermostat,
                    color: Colors.red,
                    title: loc.heatAlert ?? 'হিট এলার্ট',
                    onTap: () => Get.toNamed(AppRoutes.heatAlert),
                  ),
                  _FeatureCard(
                    icon: Icons.phone_in_talk,
                    color: Colors.green,
                    title: loc.emergencyHelpline ?? 'জরুরি হেল্পলাইন',
                    onTap: () => Get.toNamed(AppRoutes.emergencyHelpline),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // ...other dashboard content...
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  const _FeatureCard({
    required this.icon,
    required this.color,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.15),
                radius: 26,
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              // const SizedBox(height: 4),
              // Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }
}

// Weather forecast horizontal card list widget
class _WeatherForecastList extends StatelessWidget {
  final List<WeatherForecastDay> forecast;
  const _WeatherForecastList({required this.forecast});

  IconData _getWeatherIcon(double avgTemp, double humidity) {
    if (humidity > 85) {
      return Icons.water_drop;
    } else if (avgTemp >= 35) {
      return Icons.wb_sunny;
    } else if (avgTemp >= 30) {
      return Icons.wb_cloudy;
    } else {
      return Icons.cloud;
    }
  }

  LinearGradient _getCardGradient(double temp) {
    if (temp >= 35) {
      return const LinearGradient(colors: [Color(0xFFFFA726), Color(0xFFFF7043)]); // orange-red
    } else if (temp >= 30) {
      return const LinearGradient(colors: [Color(0xFFFFD54F), Color(0xFFFFB300)]); // yellow-orange
    } else if (temp >= 25) {
      return const LinearGradient(colors: [Color(0xFF64B5F6), Color(0xFF1976D2)]); // blue
    } else {
      return const LinearGradient(colors: [Color(0xFFB3E5FC), Color(0xFF0288D1)]); // light blue
    }
  }

  void _showDetails(BuildContext context, WeatherForecastDay day) {
    final date = DateTime.parse(day.date);
    final dayOfWeek = DateFormat('EEEE').format(date);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_getWeatherIcon(day.avgTemp.forecast, day.avgHumidity.forecast), size: 36),
                const SizedBox(width: 12),
                Text(dayOfWeek, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(width: 8),
                Text(DateFormat('MMM d, yyyy').format(date), style: const TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16),
            _detailRow('Avg Temp', '${day.avgTemp.forecast.toStringAsFixed(1)}°C', '(${day.avgTemp.lower}–${day.avgTemp.upper}°C)'),
            _detailRow('Max Temp', '${day.maxTemp.forecast.toStringAsFixed(1)}°C', '(${day.maxTemp.lower}–${day.maxTemp.upper}°C)'),
            _detailRow('Min Temp', '${day.minTemp.forecast.toStringAsFixed(1)}°C', '(${day.minTemp.lower}–${day.minTemp.upper}°C)'),
            _detailRow('Humidity', '${day.avgHumidity.forecast.toStringAsFixed(0)}%', '(${day.avgHumidity.lower}–${day.avgHumidity.upper}%)'),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _detailRow(String label, String value, String range) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Text(range, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, i) {
          final day = forecast[i];
          final date = DateTime.parse(day.date);
          final formatedDate = DateFormat('dd/MM/yy').format(date); // Mon, Tue, etc.
          final dayOfWeek = DateFormat('E').format(date); // Mon, Tue, etc.
          final icon = _getWeatherIcon(day.avgTemp.forecast, day.avgHumidity.forecast);
          final gradient = _getCardGradient(day.avgTemp.forecast);
          return GestureDetector(
            onTap: () => _showDetails(context, day),
            child: Container(
              width: 140,
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.18),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, color: Colors.white, size: 38),
                        const SizedBox(height: 8),
                        Text(
                          '${day.avgTemp.forecast.toStringAsFixed(1)}°C',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '↑${day.maxTemp.forecast.toStringAsFixed(0)}° ↓${day.minTemp.forecast.toStringAsFixed(0)}°',
                          style: const TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.water_drop, size: 16, color: Colors.white),
                            const SizedBox(width: 2),
                            Text('${day.avgHumidity.forecast.toStringAsFixed(0)}%', style: const TextStyle(fontSize: 14, color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                    Text(dayOfWeek, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                    // Positioned(top:0,right:0,child: Text(formatedDate, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8, color: Colors.white))),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
