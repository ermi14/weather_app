import 'package:coopah_frontend_dev_task/core/network_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coopah_frontend_dev_task/domain/entity/weather.dart';
import 'package:coopah_frontend_dev_task/domain/usecase/fetch_weather.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final FetchWeatherUseCase fetchWeatherUseCase;

  WeatherBloc(this.fetchWeatherUseCase) : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final Weather weather = await fetchWeatherUseCase.execute(
          event.lat,
          event.lon,
        );
        emit(WeatherLoadSuccess(weather));
      } on NetworkException catch (e) {
        emit(WeatherLoadFailure(e.message));
      } catch (e) {
        emit(WeatherLoadFailure(e.toString()));
      }
    });
  }
}
