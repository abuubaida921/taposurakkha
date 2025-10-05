import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'today_weather_model.dart';

class TodayWeatherService {
  static Future<TodayWeatherResponse?> fetchTodayWeather() async {
    final url = dotenv.env['API_KEY'];
    if (url == null || url.isEmpty) return null;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return TodayWeatherResponse.fromJson(jsonData);
      }
    } catch (e) {
      // Handle error
    }
    return null;
  }
}

