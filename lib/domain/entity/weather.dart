import 'package:coopah_frontend_dev_task/core/enums.dart';
import 'package:equatable/equatable.dart';

class Weather with EquatableMixin {
  final double temperature;
  final String cityName;
  final MainWeatherType main;

  Weather({
    required this.temperature,
    required this.cityName,
    required this.main,
  });

  @override
  List<Object?> get props => [
        temperature,
        cityName,
        main,
      ];
}
