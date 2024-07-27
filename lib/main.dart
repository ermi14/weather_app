import 'package:coopah_frontend_dev_task/presentation/home/bloc/weather_bloc.dart';
import 'package:coopah_frontend_dev_task/presentation/home/pages/home_page.dart';
import 'package:coopah_frontend_dev_task/presentation/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'core/constants.dart';
import 'core/injector.dart';

void main() async {
  await setupInjector();
  await dotenv.load();
  final sentryDsn = dotenv.env[Constants.sentryDsn];

  if (kReleaseMode && sentryDsn?.isNotEmpty == true) {
    await SentryFlutter.init(
      (options) {
        options.dsn = sentryDsn;
        options.tracesSampleRate = 0.01;
      },
      appRunner: () => runApp(const WeatherApp()),
    );
  } else {
    runApp(const WeatherApp());
  }
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: AppTheme.light(),
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => WeatherBloc(getIt()),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}
