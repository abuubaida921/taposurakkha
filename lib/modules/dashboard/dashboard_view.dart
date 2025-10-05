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

  Color _getTempColor(double temp) {
    if (temp >= 35) {
      return Colors.redAccent;
    } else if (temp >= 30) {
      return Colors.orangeAccent;
    } else if (temp >= 25) {
      return Colors.blueAccent;
    } else {
      return Colors.lightBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final day = forecast[i];
          final date = DateTime.parse(day.date);
          final dayOfWeek = DateFormat('E').format(date); // Mon, Tue, etc.
          final icon = _getWeatherIcon(day.avgTemp.forecast, day.avgHumidity.forecast);
          final tempColor = _getTempColor(day.avgTemp.forecast);
          return Container(
            width: 130,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, color: tempColor, size: 26),
                      const SizedBox(height: 6),
                      Text(
                        '${day.avgTemp.forecast.toStringAsFixed(1)}°C',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: tempColor),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '↑${day.maxTemp.forecast.toStringAsFixed(0)}° ↓${day.minTemp.forecast.toStringAsFixed(0)}°',
                        style: const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.water_drop, size: 16, color: Colors.blueAccent),
                          const SizedBox(width: 2),
                          Text('${day.avgHumidity.forecast.toStringAsFixed(0)}%', style: const TextStyle(fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                  Text(dayOfWeek, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
