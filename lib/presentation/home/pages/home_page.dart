import 'package:coopah_frontend_dev_task/core/enums.dart';
import 'package:coopah_frontend_dev_task/presentation/app_colors.dart';
import 'package:coopah_frontend_dev_task/presentation/home/bloc/weather_bloc.dart';
import 'package:coopah_frontend_dev_task/presentation/home/widgets/rounded_button.dart';
import 'package:coopah_frontend_dev_task/presentation/home/widgets/weather_details.dart';
import 'package:coopah_frontend_dev_task/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _inFahrenheit = false;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  void _fetchWeather() {
    context.read<WeatherBloc>().add(
          FetchWeather(
            lat: 51.51494225418024,
            lon: -0.12363193061883422,
          ),
        );
  }

  String kelvinToCelsius(double kelvin) {
    return (kelvin - 273.15).toStringAsFixed(0);
  }

  String kelvinToFahrenheit(double kelvin) {
    return ((kelvin * 9 / 5) - 459.67).toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: AppPaddings.ax3.add(AppPaddings.vx2),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildWeatherCard(context),
                  WeatherDetails(theme: theme, inFahrenheit: _inFahrenheit),
                  _buildSwitch(context),
                  AppSpacings.x2,
                ],
              ),
            ),
            _buildRefreshButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherCard(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSpacings.x4,
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: AspectRatio(
              aspectRatio: size.width > 300 ? 16 / 9 : 4 / 3,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: AppPaddings.ax4.add(AppPaddings.vx4),
                  child: _buildWeatherIconBasedOnState(context),
                ),
              ),
            ),
          ),
        ),
        AppSpacings.x3,
        Text(
          'This is My Weather App',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        AppSpacings.x3,
      ],
    );
  }

  Widget _buildWeatherIconBasedOnState(BuildContext context) {
    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is WeatherLoadFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is WeatherLoadSuccess) {
          switch (state.weather.main) {
            case MainWeatherType.clear:
              return const Icon(
                Icons.wb_sunny,
                size: 96,
                color: AppColors.darkGrayColor,
              );
            case MainWeatherType.clouds:
              return const Icon(
                Icons.cloud_outlined,
                size: 96,
                color: AppColors.darkGrayColor,
              );
            case MainWeatherType.rain:
              return const Icon(
                Icons.beach_access,
                size: 96,
                color: AppColors.darkGrayColor,
              );
            default:
              return const Icon(
                Icons.sunny,
                size: 96,
                color: AppColors.darkGrayColor,
              );
          }
        }
        return AppSpacings.withFactor(12);
      },
    );
  }

  Widget _buildSwitch(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Degrees/Fahrenheit',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        AppSpacings.x1,
        BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            return Switch.adaptive(
              value: _inFahrenheit,
              onChanged: state is WeatherLoadSuccess
                  ? (value) {
                      setState(() {
                        _inFahrenheit = value;
                      });
                    }
                  : null,
              activeColor: Theme.of(context).colorScheme.primary,
            );
          },
        )
      ],
    );
  }

  Widget _buildRefreshButton(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return RoundedButton(
                onPressed: _fetchWeather,
                child: const Text('Refresh'),
              );
            },
          ),
        ],
      ),
    );
  }
}
