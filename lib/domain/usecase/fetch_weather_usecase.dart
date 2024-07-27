import 'package:coopah_frontend_dev_task/core/data_wrapper.dart';
import 'package:coopah_frontend_dev_task/domain/entity/weather.dart';
import 'package:coopah_frontend_dev_task/domain/repository/weather_repository.dart';

abstract class FetchWeatherUseCase {
  Future<DataWrapper<Weather>> execute(double lat, double lon);
}

class FetchWeatherUseCaseImpl implements FetchWeatherUseCase {
  final WeatherRepository repository;

  FetchWeatherUseCaseImpl(this.repository);

  @override
  Future<DataWrapper<Weather>> execute(double lat, double lon) async {
    try {
      return await repository.fetchWeather(lat, lon);
    } catch (e) {
      rethrow;
    }
  }
}
