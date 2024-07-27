import 'package:coopah_frontend_dev_task/core/data_wrapper.dart';
import 'package:coopah_frontend_dev_task/core/enums.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:coopah_frontend_dev_task/domain/usecase/fetch_weather_usecase.dart';
import 'package:coopah_frontend_dev_task/presentation/home/bloc/weather_bloc.dart';
import 'package:coopah_frontend_dev_task/domain/entity/weather.dart';

class MockFetchWeatherUseCase extends Mock implements FetchWeatherUseCase {}

void main() {
  late MockFetchWeatherUseCase mockFetchWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockFetchWeatherUseCase = MockFetchWeatherUseCase();
    weatherBloc = WeatherBloc(mockFetchWeatherUseCase);
  });

  group('WeatherBloc Tests', () {
    final tWeather = Weather(
      temperature: 20,
      cityName: 'Test City',
      main: MainWeatherType.clear,
    );

    final tWeatherDataWrapper = DataWrapper<Weather>(
      data: tWeather,
      error: null,
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoadSuccess] '
      'when FetchWeather event is added and use case returns weather',
      build: () {
        when(() => mockFetchWeatherUseCase.execute(any(), any()))
            .thenAnswer((_) async => tWeatherDataWrapper);
        return weatherBloc;
      },
      act: (bloc) => bloc.add(FetchWeather(lat: 0.0, lon: 0.0)),
      expect: () => [WeatherLoading(), WeatherLoadSuccess(tWeather)],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoadFailure] '
      'when FetchWeather event is added and use case throws Exception',
      build: () {
        when(() => mockFetchWeatherUseCase.execute(any(), any())).thenThrow(
          Exception('Failed to fetch weather'),
        );
        return weatherBloc;
      },
      act: (bloc) => bloc.add(FetchWeather(lat: 0.0, lon: 0.0)),
      expect: () => [
        WeatherLoading(),
        WeatherLoadFailure('Exception: Failed to fetch weather')
      ],
    );
  });

  tearDown(() {
    weatherBloc.close();
  });
}
