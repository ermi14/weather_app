import 'package:coopah_frontend_dev_task/core/constants.dart';
import 'package:coopah_frontend_dev_task/core/network_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherApi {
  final Dio dio;

  WeatherApi(this.dio);

  Future<Response> fetchWeather(double lat, double lon) async {
    try {
      await dotenv.load();
      final apiKey = dotenv.env[Constants.apiKey];

      final response = await dio.get(
        Constants.baseUrl,
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': apiKey,
        },
      );

      return response;
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    } catch(e) {
      throw NetworkException.fromMessage('Failed to load weather data', null);
    }
  }
}
