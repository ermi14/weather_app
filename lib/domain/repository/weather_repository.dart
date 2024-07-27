import 'package:coopah_frontend_dev_task/core/data_wrapper.dart';
import 'package:coopah_frontend_dev_task/domain/entity/weather.dart';

abstract class WeatherRepository {
  Future<DataWrapper<Weather>> fetchWeather(double lat, double lon);
}
