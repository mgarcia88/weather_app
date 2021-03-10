import 'package:weather/app/models/location.model.dart';

class CityService{
  List<LocationModel> _availableCities;

  List<LocationModel> get availableCities => _availableCities;

  CityService(){
    _availableCities = [];
    _getAvailableCities();
  }

  _getAvailableCities(){
    _availableCities.add(new LocationModel(country: "", state: "", name: "Selecione a cidade"));
    _availableCities.add(new LocationModel(country: "EN", state: "", name: "London"));
    _availableCities.add(new LocationModel(country: "BR", state: "RJ", name: "Rio de Janeiro"));
    _availableCities.add(new LocationModel(country: "BR", state: "SP", name: "São Paulo"));
    _availableCities.add(new LocationModel(country: "USA", state: "", name: "Boston"));
    _availableCities.add(new LocationModel(country: "USA", state: "", name: "New york"));
  }
}