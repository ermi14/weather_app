import 'package:coopah_frontend_dev_task/data/data_source/remote/weather_api.dart';
import 'package:coopah_frontend_dev_task/data/repository/weather_repository_impl.dart';
import 'package:coopah_frontend_dev_task/domain/repository/weather_repository.dart';
import 'package:coopah_frontend_dev_task/domain/usecase/fetch_weather_usecase.dart';
import 'package:coopah_frontend_dev_task/presentation/home/bloc/weather_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupInjector() async {
  // Bloc
  getIt.registerFactory(() => WeatherBloc(getIt()));

  // Use case
  getIt.registerLazySingleton<FetchWeatherUseCase>(
    () => FetchWeatherUseCaseImpl(getIt()),
  );

  // Repository
  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(getIt()),
  );

  // Data source
  getIt.registerLazySingleton<WeatherApi>(
    () => WeatherApi(getIt()),
  );

  // Dio
  getIt.registerLazySingleton(
    () => Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 5),
    )),
  );
}
