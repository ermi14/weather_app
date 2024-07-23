import 'package:coopah_frontend_dev_task/data/data_source/remote/weather_api.dart';
import 'package:coopah_frontend_dev_task/data/dto/weather_dto.dart';
import 'package:coopah_frontend_dev_task/domain/entity/weather.dart';
import 'package:coopah_frontend_dev_task/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApi _weatherApi;

  WeatherRepositoryImpl(this._weatherApi);

  @override
  Future<Weather> fetchWeather(double lat, double lon) async {
    try {
      final jsonData = await _weatherApi.fetchWeather(lat, lon);
      return WeatherDto.fromJson(jsonData);
    } catch (e) {
      rethrow;
    }
  }
}