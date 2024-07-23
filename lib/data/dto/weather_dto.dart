import 'package:coopah_frontend_dev_task/core/enums.dart';
import 'package:coopah_frontend_dev_task/domain/entity/weather.dart';

class WeatherDto extends Weather {
  WeatherDto({
    required super.temperature,
    required super.cityName,
    required super.main,
  });

  factory WeatherDto.fromJson(Map<String, dynamic> json) {
    return WeatherDto(
      temperature: json['main']['temp'].toDouble(),
      cityName: json['name'],
      main: _mapStringToMainWeatherType(json['weather'][0]['main']),
    );
  }

  static MainWeatherType _mapStringToMainWeatherType(String main) {
    switch (main) {
      case 'Clear':
        return MainWeatherType.clear;
      case 'Clouds':
        return MainWeatherType.clouds;
      case 'Rain':
        return MainWeatherType.rain;
      default:
        return MainWeatherType.other;
    }
  }
}


