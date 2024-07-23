import 'package:coopah_frontend_dev_task/domain/entity/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeather(double lat, double lon);
}
