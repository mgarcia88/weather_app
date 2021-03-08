import 'package:weather/app/models/location.model.dart';
import 'package:weather/app/models/weather.model.dart';

abstract class IWeatherApiClient
{
   Future<LocationModel> fetchCityInformationByNameAndState(String name, String state);

   Future<WeatherModel> fetchWeatherInformationByCityId(int id);
}