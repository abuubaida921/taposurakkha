// Model for weather forecast API response
class WeatherForecastResponse {
  final String status;
  final WeatherForecastData data;

  WeatherForecastResponse({required this.status, required this.data});

  factory WeatherForecastResponse.fromJson(Map<String, dynamic> json) {
    return WeatherForecastResponse(
      status: json['status'],
      data: WeatherForecastData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data.toJson(),
  };
}

class WeatherForecastData {
  final WeatherForecastMeta meta;
  final List<WeatherForecastDay> forecast;

  WeatherForecastData({required this.meta, required this.forecast});

  factory WeatherForecastData.fromJson(Map<String, dynamic> json) {
    return WeatherForecastData(
      meta: WeatherForecastMeta.fromJson(json['meta']),
      forecast: (json['forecast'] as List)
          .map((e) => WeatherForecastDay.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'meta': meta.toJson(),
    'forecast': forecast.map((e) => e.toJson()).toList(),
  };
}

class WeatherForecastMeta {
  final String method;
  final int horizon;
  final String start;
  final String csvFirst;
  final String csvLast;
  final List<String> targets;
  final int biasWindow;
  final double biasDamp;
  final String avgHumidityBiasMode;
  final String avgTempBiasMode;
  final String maxTempBiasMode;
  final String minTempBiasMode;

  WeatherForecastMeta({
    required this.method,
    required this.horizon,
    required this.start,
    required this.csvFirst,
    required this.csvLast,
    required this.targets,
    required this.biasWindow,
    required this.biasDamp,
    required this.avgHumidityBiasMode,
    required this.avgTempBiasMode,
    required this.maxTempBiasMode,
    required this.minTempBiasMode,
  });

  factory WeatherForecastMeta.fromJson(Map<String, dynamic> json) {
    return WeatherForecastMeta(
      method: json['method'],
      horizon: json['horizon'],
      start: json['start'],
      csvFirst: json['csv_first'],
      csvLast: json['csv_last'],
      targets: List<String>.from(json['targets']),
      biasWindow: json['bias_window'],
      biasDamp: (json['bias_damp'] as num).toDouble(),
      avgHumidityBiasMode: json['avg_humidity_bias_mode'],
      avgTempBiasMode: json['avg_temp_bias_mode'],
      maxTempBiasMode: json['max_temp_bias_mode'],
      minTempBiasMode: json['min_temp_bias_mode'],
    );
  }

  Map<String, dynamic> toJson() => {
    'method': method,
    'horizon': horizon,
    'start': start,
    'csv_first': csvFirst,
    'csv_last': csvLast,
    'targets': targets,
    'bias_window': biasWindow,
    'bias_damp': biasDamp,
    'avg_humidity_bias_mode': avgHumidityBiasMode,
    'avg_temp_bias_mode': avgTempBiasMode,
    'max_temp_bias_mode': maxTempBiasMode,
    'min_temp_bias_mode': minTempBiasMode,
  };
}

class WeatherForecastDay {
  final String date;
  final WeatherForecastValue avgHumidity;
  final WeatherForecastValue avgTemp;
  final WeatherForecastValue maxTemp;
  final WeatherForecastValue minTemp;

  WeatherForecastDay({
    required this.date,
    required this.avgHumidity,
    required this.avgTemp,
    required this.maxTemp,
    required this.minTemp,
  });

  factory WeatherForecastDay.fromJson(Map<String, dynamic> json) {
    return WeatherForecastDay(
      date: json['date'],
      avgHumidity: WeatherForecastValue.fromJson(json['avg_humidity']),
      avgTemp: WeatherForecastValue.fromJson(json['avg_temp']),
      maxTemp: WeatherForecastValue.fromJson(json['max_temp']),
      minTemp: WeatherForecastValue.fromJson(json['min_temp']),
    );
  }

  Map<String, dynamic> toJson() => {
    'date': date,
    'avg_humidity': avgHumidity.toJson(),
    'avg_temp': avgTemp.toJson(),
    'max_temp': maxTemp.toJson(),
    'min_temp': minTemp.toJson(),
  };
}

class WeatherForecastValue {
  final double forecast;
  final double lower;
  final double upper;

  WeatherForecastValue({required this.forecast, required this.lower, required this.upper});

  factory WeatherForecastValue.fromJson(Map<String, dynamic> json) {
    return WeatherForecastValue(
      forecast: (json['forecast'] as num).toDouble(),
      lower: (json['lower'] as num).toDouble(),
      upper: (json['upper'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'forecast': forecast,
    'lower': lower,
    'upper': upper,
  };
}
