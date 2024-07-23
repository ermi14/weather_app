part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  final Weather weather;

  WeatherLoadSuccess(this.weather);

  @override
  List<Object?> get props => [weather];
}

class WeatherLoadFailure extends WeatherState {
  final String message;

  WeatherLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}
