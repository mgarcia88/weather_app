import 'package:dio/dio.dart';
import 'package:weather/app/infrastructure/interfaces/weather-api-client.interface.dart';
import 'package:weather/app/models/location.model.dart';
import 'package:weather/app/models/weather.model.dart';

class ClimaTempoClient implements IWeatherApiClient {
  String baseUrl = "http://apiadvisor.climatempo.com.br/api/v1";
  var dio;
  String token = "db2f8873abaea171f88a04e297efcdb3";

  ClimaTempoClient() {
    dio = Dio();
  }

  Future<LocationModel> fetchCityInformationByNameAndState(
      String name, String state) async {
    var cityInformation = await dio
        .get("$baseUrl/locale/city?name=$name&state=$state&token=$token");

    return LocationModel.fromJson(cityInformation.data[0]);
  }

  @override
  Future<WeatherModel> fetchWeatherInformationByCityId(int id) {
    throw UnimplementedError();
  }

 
}
