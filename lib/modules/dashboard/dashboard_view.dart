import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taposurakkha/app/routes.dart';
import 'package:taposurakkha/app/shared_preferences_helper.dart';
import 'package:taposurakkha/app/toast_helper.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/beautiful_loader.dart';
import '../../l10n/app_localizations.dart';
import '../../app/localization_controller.dart';
import 'weather_forecast_model.dart';
import 'weather_forecast_service.dart';
import 'today_weather_model.dart';
import 'today_weather_service.dart';
import 'weather_details_bottom_sheet.dart';

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

  TodayWeatherResponse? _todayWeather;
  bool _todayWeatherLoading = true;

  static const String _weatherCacheKey = 'weather_forecast_cache';

  @override
  void initState() {
    super.initState();
    _checkAuth();
    _loadCachedForecast();
    _fetchTodayWeather();
    _fetchForecast();
  }

  Future<void> _checkAuth() async {
    setState(() {
      _loading = false;
    });
  }

  Future<void> _loadCachedForecast() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(_weatherCacheKey);
    if (cached != null) {
      try {
        final jsonData = json.decode(cached);
        final cachedResponse = WeatherForecastResponse.fromJson(jsonData);
        setState(() {
          _forecastResponse = cachedResponse;
          _forecastLoading = false;
        });
      } catch (_) {}
    }
  }

  Future<void> _cacheForecast(WeatherForecastResponse response) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(response.toJson());
    await prefs.setString(_weatherCacheKey, jsonString);
  }

  Future<void> _fetchForecast() async {
    setState(() {
      _forecastLoading = _forecastResponse == null; // Only show loader if no cache
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
        _cacheForecast(res);
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

  Future<void> _fetchTodayWeather() async {
    setState(() {
      _todayWeatherLoading = true;
    });
    final res = await TodayWeatherService.fetchTodayWeather();
    if (res != null) {
      // Optionally adjust temp to blend with forecast
      final adjusted = TodayWeatherResponse(
        location: res.location,
        current: TodayWeatherCurrent(
          tempC: res.current.tempC + (res.current.tempC > 25 ? -0.5 : 0.5),
          humidity: res.current.humidity,
          conditionText: res.current.conditionText,
          conditionIcon: res.current.conditionIcon,
          feelslikeC: res.current.feelslikeC,
          windKph: res.current.windKph,
          cloud: res.current.cloud,
        ),
      );
      setState(() {
        _todayWeather = adjusted;
        _todayWeatherLoading = false;
      });
    } else {
      setState(() {
        _todayWeatherLoading = false;
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
        body: const Center(child: BeautifulLoader()),
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
              // Today's Weather Card
              if (_todayWeatherLoading)
                const Center(child: BeautifulLoader())
              else if (_todayWeather != null)
                _TodayWeatherCard(today: _todayWeather!),
              const SizedBox(height: 18),
              // Weather Forecast Section
              Text(loc.weatherForecast ?? 'Weather Forecast', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              if (_forecastLoading)
                const Center(child: BeautifulLoader())
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
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => WeatherDetailsBottomSheet(
        title: dayOfWeek,
        subtitle: DateFormat('MMM d, yyyy').format(date),
        iconAsset: null,
        temp: '${day.avgTemp.forecast.toStringAsFixed(1)}°C',
        minTemp: '${day.minTemp.forecast.toStringAsFixed(1)}°C',
        maxTemp: '${day.maxTemp.forecast.toStringAsFixed(1)}°C',
        humidity: '${day.avgHumidity.forecast.toStringAsFixed(0)}%',
        range: '(${day.avgTemp.lower}–${day.avgTemp.upper}°C)',
        extraRows: [
          _WeatherForecastList._detailRowPro('Max Temp', '${day.maxTemp.forecast.toStringAsFixed(1)}°C', '(${day.maxTemp.lower}–${day.maxTemp.upper}°C)', Icons.arrow_upward, Colors.redAccent),
          _WeatherForecastList._detailRowPro('Min Temp', '${day.minTemp.forecast.toStringAsFixed(1)}°C', '(${day.minTemp.lower}–${day.minTemp.upper}°C)', Icons.arrow_downward, Colors.blueAccent),
        ],
      ),
    );
  }

  static Widget _detailRowPro(String label, String value, String range, IconData icon, Color iconColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 26),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              Row(
                children: [
                  Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(width: 8),
                  Text(range, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
      ],
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

// Today's weather card widget
class _TodayWeatherCard extends StatelessWidget {
  final TodayWeatherResponse today;
  const _TodayWeatherCard({required this.today});

  void _showDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => WeatherDetailsBottomSheet(
        title: today.location.name,
        subtitle: today.location.country,
        iconUrl: 'https:${today.current.conditionIcon}',
        temp: '${today.current.tempC.toStringAsFixed(1)}°C',
        feelsLike: '${today.current.feelslikeC.toStringAsFixed(1)}°C',
        humidity: '${today.current.humidity}%',
        wind: '${today.current.windKph} km/h',
        cloud: '${today.current.cloud}%',
        extraRows: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(today.current.conditionText, style: const TextStyle(fontSize: 15, color: Colors.blueAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDetails(context),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https:${today.current.conditionIcon}',
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      today.location.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${today.current.tempC.toStringAsFixed(1)}°C',
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      today.current.conditionText,
                      style: const TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.water_drop, color: Colors.white70, size: 20),
                  const SizedBox(height: 4),
                  Text(
                    '${today.current.humidity}%',
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

