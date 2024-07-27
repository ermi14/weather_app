import 'package:coopah_frontend_dev_task/core/data_wrapper.dart';
import 'package:coopah_frontend_dev_task/core/network_exception.dart';
import 'package:coopah_frontend_dev_task/data/data_source/remote/weather_api.dart';
import 'package:coopah_frontend_dev_task/data/dto/weather_dto.dart';
import 'package:coopah_frontend_dev_task/domain/entity/weather.dart';
import 'package:coopah_frontend_dev_task/domain/repository/weather_repository.dart';
import 'package:dio/dio.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApi _weatherApi;

  WeatherRepositoryImpl(this._weatherApi);

  @override
  Future<DataWrapper<Weather>> fetchWeather(double lat, double lon) async {
    try {
      final response = await _weatherApi.fetchWeather(lat, lon);

      if (response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return DataWrapper.success(WeatherDto.fromJson(response.data));
        } else {
          return DataWrapper.error(
            NetworkException.fromDioError(
              DioException(
                requestOptions: response.requestOptions,
                response: response,
              ),
            ),
          );
        }
      } else {
        return DataWrapper.error(
          NetworkException.fromMessage('Failed to load weather data', null),
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
