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

// Weather forecast list widget
class _WeatherForecastList extends StatelessWidget {
  final List<WeatherForecastDay> forecast;
  const _WeatherForecastList({required this.forecast});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: forecast.length,
      separatorBuilder: (_, __) => const Divider(height: 8),
      itemBuilder: (context, i) {
        final day = forecast[i];
        return Card(
          child: ListTile(
            leading: Icon(Icons.calendar_today, color: Colors.teal),
            title: Text(DateFormat('MMM d, yyyy').format(DateTime.parse(day.date))),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Avg Temp: ${day.avgTemp.forecast.toStringAsFixed(1)}°C (Min: ${day.minTemp.forecast.toStringAsFixed(1)}°C, Max: ${day.maxTemp.forecast.toStringAsFixed(1)}°C)'),
                Text('Humidity: ${day.avgHumidity.forecast.toStringAsFixed(0)}%'),
              ],
            ),
          ),
        );
      },
    );
  }
}
