import 'package:coopah_frontend_dev_task/core/data_wrapper.dart';
import 'package:coopah_frontend_dev_task/core/enums.dart';
import 'package:coopah_frontend_dev_task/domain/entity/weather.dart';
import 'package:coopah_frontend_dev_task/domain/repository/weather_repository.dart';
import 'package:coopah_frontend_dev_task/domain/usecase/fetch_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late FetchWeatherUseCase useCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    useCase = FetchWeatherUseCaseImpl(mockWeatherRepository);
  });

  const tLatitude = 51.5074;
  const tLongitude = -0.1278;
  final tWeather = Weather(
    temperature: 20,
    cityName: 'London',
    main: MainWeatherType.clear,
  );

  final tWeatherDataWrapper = DataWrapper<Weather>(
    data: tWeather,
    error: null,
  );

  test('should get weather for the given location from the repository',
      () async {
    when(
      () => mockWeatherRepository.fetchWeather(any(), any()),
    ).thenAnswer((_) async => tWeatherDataWrapper);

    final result = await useCase.execute(tLatitude, tLongitude);

    expect(result, tWeatherDataWrapper);
    verify(
      () => mockWeatherRepository.fetchWeather(tLatitude, tLongitude),
    ).called(1);
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
