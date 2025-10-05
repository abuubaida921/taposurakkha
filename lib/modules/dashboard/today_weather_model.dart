class TodayWeatherResponse {
  final TodayWeatherLocation location;
  final TodayWeatherCurrent current;

  TodayWeatherResponse({required this.location, required this.current});

  factory TodayWeatherResponse.fromJson(Map<String, dynamic> json) {
    return TodayWeatherResponse(
      location: TodayWeatherLocation.fromJson(json['location']),
      current: TodayWeatherCurrent.fromJson(json['current']),
    );
  }
}

class TodayWeatherLocation {
  final String name;
  final String country;
  final String localtime;

  TodayWeatherLocation({required this.name, required this.country, required this.localtime});

  factory TodayWeatherLocation.fromJson(Map<String, dynamic> json) {
    return TodayWeatherLocation(
      name: json['name'],
      country: json['country'],
      localtime: json['localtime'],
    );
  }
}

class TodayWeatherCurrent {
  final double tempC;
  final int humidity;
  final String conditionText;
  final String conditionIcon;
  final double feelslikeC;
  final double windKph;
  final int cloud;

  TodayWeatherCurrent({
    required this.tempC,
    required this.humidity,
    required this.conditionText,
    required this.conditionIcon,
    required this.feelslikeC,
    required this.windKph,
    required this.cloud,
  });

  factory TodayWeatherCurrent.fromJson(Map<String, dynamic> json) {
    return TodayWeatherCurrent(
      tempC: (json['temp_c'] as num).toDouble(),
      humidity: json['humidity'],
      conditionText: json['condition']['text'],
      conditionIcon: json['condition']['icon'],
      feelslikeC: (json['feelslike_c'] as num).toDouble(),
      windKph: (json['wind_kph'] as num).toDouble(),
      cloud: json['cloud'],
    );
  }
}

