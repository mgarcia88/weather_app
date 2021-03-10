import 'package:weather/app/infrastructure/interfaces/http-client.interface.dart';
import 'package:weather/app/models/location.model.dart';
import 'package:weather/app/models/metaweather.model.dart';
import 'package:weather/app/models/weather.model.dart';

import 'interfaces/weather-api-client.interface.dart';

class MetaWeatherClient implements IWeatherApiClient {
  String baseUrl = "https://www.metaweather.com/api";
  IHttpClient _httpClient;

  MetaWeatherClient(IHttpClient httpClient)
  {
    _httpClient = httpClient;
  }

  @override
  Future<LocationModel> fetchCityInformationByNameAndState(
      String name, String state) async {
    var cityInformation =
        await _httpClient.get("$baseUrl/location/search/?query=$name");

    return Future.value(new LocationModel(
        name: cityInformation.data[0]["title"],
        id: cityInformation.data[0]["woeid"]));
  }

  @override
  Future<WeatherModel> fetchWeatherInformationByCityId(int id) async{
    var weatherInformation = await _httpClient.get("$baseUrl/location/$id/");

    return Future.value(new MetaWeatherModel.fromJson(weatherInformation.data));
  }
}
