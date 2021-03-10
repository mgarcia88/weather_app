import 'dart:async';
import 'package:weather/app/infrastructure/interfaces/weather-api-client.interface.dart';
import 'package:weather/app/models/location.model.dart';
import 'package:weather/app/models/metaweather.model.dart';
import 'package:weather/app/services/city.service.dart';

class WeatherBloc {
  IWeatherApiClient _weatherApiClient;
  var cityService = new CityService();

  final _weatherFetcher = StreamController<bool>();

  Stream<bool> get isLoading => _weatherFetcher.stream;

  MetaWeatherModel get allPredictsWeather => _allPredictsWeather;

  MetaWeatherModel _allPredictsWeather;

  String _citySelectedValue = "Selecione a cidade";

  String get citySelectedValue => _citySelectedValue;

  WeatherBloc(IWeatherApiClient weatherApiClient) {
    _weatherApiClient = weatherApiClient;
    fetchAvailableCities();
  }

  void changeSelectedCity(String value) {
    _citySelectedValue = value;
  }

  void fetchCityInformationByName(String name) async {
    if (name != "Selecione a cidade") {
      changeSelectedCity(name);
      _weatherFetcher.sink.add(true);
      var cities = cityService.availableCities;
      var location = cities.where((element) => element.name == name).first;

      if (location != null) {
        var apiResult = await _weatherApiClient
            .fetchCityInformationByNameAndState(name, location.state);

        if (apiResult != null) {
          _allPredictsWeather = await _weatherApiClient
              .fetchWeatherInformationByCityId(apiResult.id);

          _weatherFetcher.sink.add(false);
        }
      }
    }
  }

  List<LocationModel> fetchAvailableCities() {
    return cityService.availableCities;
  }

  dispose() {
    _weatherFetcher.close();
  }
}
