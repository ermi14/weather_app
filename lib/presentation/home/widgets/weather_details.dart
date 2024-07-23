import 'package:coopah_frontend_dev_task/presentation/home/bloc/weather_bloc.dart';
import 'package:coopah_frontend_dev_task/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({
    super.key,
    required this.theme,
    required this.inFahrenheit,
  });

  final ThemeData theme;
  final bool inFahrenheit;

  String kelvinToCelsius(double kelvin) => (kelvin - 273.15).toStringAsFixed(0);

  String kelvinToFahrenheit(double kelvin) =>
      ((kelvin * 9 / 5) - 459.67).toStringAsFixed(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Temperature',
          style: theme.textTheme.titleLarge,
        ),
        AppSpacings.x1,
        BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoadSuccess) {
              final temperature = state.weather.temperature;
              return Text(
                !inFahrenheit
                    ? '${kelvinToCelsius(temperature)} degrees'
                    : '${kelvinToFahrenheit(temperature)} fahrenheit',
                style: theme.textTheme.bodyMedium,
              );
            }
            return AppSpacings.x2;
          },
        ),
        AppSpacings.x2,
        Text(
          'Location',
          style: theme.textTheme.titleLarge,
        ),
        AppSpacings.x1,
        BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoadSuccess) {
              return Text(
                state.weather.cityName,
                style: theme.textTheme.bodyMedium,
              );
            }
            return AppSpacings.x2;
          },
        ),
        AppSpacings.x2,
      ],
    );
  }
}
