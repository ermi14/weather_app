import 'package:coopah_frontend_dev_task/core/constants.dart';
import 'package:coopah_frontend_dev_task/core/network_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherApi {
  final Dio dio;

  WeatherApi(this.dio);

  Future<Map<String, dynamic>> fetchWeather(double lat, double lon) async {
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

      return response.data;
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    } catch(e) {
      throw Exception('Failed to load weather data');
    }
  }
}
