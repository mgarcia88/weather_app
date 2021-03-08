import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:weather/app/enums/weather-condition.enum.dart';
import 'package:weather/app/enums/weather-icon.enum.dart';
import 'package:weather/app/infrastructure/interfaces/weather-api-client.interface.dart';
import 'package:weather/app/models/location.model.dart';
import 'package:weather/app/models/weather.model.dart';
import 'package:weather/app/services/city.service.dart';

class WeatherBloc {
  IWeatherApiClient _weatherApiClient;
  var cityService = new CityService();

  final _citiesFetcher = StreamController<List<LocationModel>>();

  Stream<List<LocationModel>> get allAvailableCities => _citiesFetcher.stream;

  final _weatherFetcher = StreamController<WeatherModel>();

  Stream<WeatherModel> get allPredictsWeather => _weatherFetcher.stream;

  WeatherBloc(IWeatherApiClient weatherApiClient) {
    _weatherApiClient = weatherApiClient;
    fetchAvailableCities();
  }

  void fetchCityInformationByName(String name) async {
    var cities = cityService.availableCities;
    var location = cities.where((element) => element.name == name).first;

    if (location != null) {
      var apiResult = await _weatherApiClient
          .fetchCityInformationByNameAndState(name, location.state);

      if (apiResult != null) {
        var weatherApiResult = await _weatherApiClient
            .fetchWeatherInformationByCityId(apiResult.id);

        _weatherFetcher.sink.add(weatherApiResult);
      }
    }
  }

  void fetchAvailableCities() {
    _citiesFetcher.sink.add(cityService.availableCities);
  }

  IconData getIconFromWeatherCondition(String weatherCondition) {
    switch (weatherCondition) {
      case "Clear":
        return WeatherIconEnum.clear;
        break;
      case "Snow":
        return WeatherIconEnum.snow;
        break;
      case "Sleet":
        return WeatherIconEnum.sleet;
        break;
      case "Hail":
        return WeatherIconEnum.hail;
        break;
      case "Thunderstorm":
        return WeatherIconEnum.thunderstorm;
        break;
      case "Heavy Rain":
        return WeatherIconEnum.heavyRain;
        break;
      case "Light Rain":
        return WeatherIconEnum.lightRain;
        break;
      case "Showers":
        return WeatherIconEnum.showers;
        break;
      case "Heavy Cloud":
        return WeatherIconEnum.heavyCloud;
        break;
      case "Light Cloud":
        return WeatherIconEnum.lightCloud;
        break;
      case "Unknown":
        return WeatherIconEnum.unknown;
        break;
    }
  }
}
