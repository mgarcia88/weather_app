import 'package:get_it/get_it.dart';
import 'package:weather/app/infrastructure/dio-http-client.dart';
import 'package:weather/app/infrastructure/interfaces/http-client.interface.dart';
import 'package:weather/app/infrastructure/interfaces/weather-api-client.interface.dart';
import 'package:weather/app/infrastructure/metaweather.client.dart';

final locator = GetIt.instance;

void setupServiceLocator() {
  locator.registerLazySingleton<IWeatherApiClient>(() => MetaWeatherClient());
  locator.registerLazySingleton<IHttpClient>(() => DioHttpClient());
}
