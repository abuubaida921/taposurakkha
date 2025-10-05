import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_forecast_model.dart';

class WeatherForecastService {
  static Future<WeatherForecastResponse?> fetchForecast({
    required String start,
    int horizon = 7,
    String method = 'climo',
  }) async {
    final url = Uri.parse(
      'https://demo.abuubaida921.com/forcasting/forecast_from_cleaned.php?start=$start&horizon=$horizon&method=$method',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return WeatherForecastResponse.fromJson(jsonData);
      }
    } catch (e) {
      // Handle error
    }
    return null;
  }
}

