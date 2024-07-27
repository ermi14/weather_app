import 'package:coopah_frontend_dev_task/core/network_exception.dart';
import 'package:coopah_frontend_dev_task/core/report_error.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coopah_frontend_dev_task/domain/entity/weather.dart';
import 'package:coopah_frontend_dev_task/domain/usecase/fetch_weather_usecase.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final FetchWeatherUseCase fetchWeatherUseCase;

  WeatherBloc(this.fetchWeatherUseCase) : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final response = await fetchWeatherUseCase.execute(
          event.lat,
          event.lon,
        );
        if (response.data != null && response.data is Weather) {
          emit(WeatherLoadSuccess(response.data!));
        } else if (response.error != null) {
          emit(WeatherLoadFailure(response.error!.message));
        }
      } on NetworkException catch (e, stackTrace) {
        ReportError.reportErrorSentry(e, stackTrace);
        emit(WeatherLoadFailure(e.message));
      } catch (e, stackTrace) {
        ReportError.reportErrorSentry(Exception(e.toString()), stackTrace);
        emit(WeatherLoadFailure(e.toString()));
      }
    });
  }
}
