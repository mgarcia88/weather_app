import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:weather/app/controllers/weather.bloc.dart';
import 'package:weather/app/enums/weather-condition.enum.dart';
import 'package:weather/app/infrastructure/interfaces/weather-api-client.interface.dart';
import 'package:weather/app/infrastructure/locator/locator.service.dart';
import 'package:weather/app/models/location.model.dart';

class WeatherDisplayView extends StatefulWidget {
  @override
  _WeatherDisplayViewState createState() => _WeatherDisplayViewState();
}

class _WeatherDisplayViewState extends State<WeatherDisplayView> {
  var _controller;
  List<LocationModel> _cities;

  Map<String, IconData> _enumDescriptionIcon = {
    WeatherCondition.SNOW.toUpperCase(): Mdi.weatherSnowyHeavy,
    WeatherCondition.SLEET.toString(): Mdi.sleep,
    WeatherCondition.HAIL.toString(): Mdi.weatherHail,
    WeatherCondition.THUNDERSTORM.toString(): Mdi.weatherLightningRainy,
    WeatherCondition.HEAVYRAIN.toString(): Mdi.weatherPouring,
    WeatherCondition.LIGHTRAIN.toString(): Mdi.weatherRainy,
    WeatherCondition.SHOWERS.toString(): Mdi.weatherPartlySnowyRainy,
    WeatherCondition.HEAVYCLOUD.toString(): Mdi.weatherCloudyAlert,
    WeatherCondition.LIGHTCLOUD.toString(): Mdi.weatherPartlyCloudy,
    WeatherCondition.CLEAR.toString(): Mdi.weatherSunny,
    WeatherCondition.UNKNOWN.toString(): Mdi.weatherSunnyOff
  };

  @override
  void initState() {
    super.initState();
    _controller = new WeatherBloc(locator.get<IWeatherApiClient>());
    _cities = _controller.fetchAvailableCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Previsão do tempo"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              children: [
                citiesList(_cities),
                SizedBox(height: 30),
                _showWeatherPrediction()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget citiesList(List<LocationModel> data) {
    return DropdownButtonFormField(
        elevation: 20,
        iconSize: 28,
        iconDisabledColor: Colors.grey,
        iconEnabledColor: Colors.indigo,
        onChanged: (value) {
          _controller.fetchCityInformationByName(value);
        },
        value: _controller.citySelectedValue,
        items: data.map<DropdownMenuItem<String>>((LocationModel value) {
          return DropdownMenuItem<String>(
            value: value.name,
            child: Text(value.name),
          );
        }).toList());
  }

  Widget _showWeatherPrediction() {
    return Container(
      height: 200,
      child: StreamBuilder(
          stream: _controller.isLoading,
          builder: (context, snapshot) {
            if (snapshot.hasData && !snapshot.data) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      _controller.allPredictsWeather.consolidatedWeather.length,
                  itemBuilder: (context, index) {
                    var weather = _controller
                        .allPredictsWeather.consolidatedWeather[index];

                    return Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 500,
                      child: Card(
                        elevation: 9,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(_enumDescriptionIcon[
                                  weather.weatherStateName]),
                              Text(weather.applicableDate),
                              Text(weather.weatherStateName),
                            ]),
                      ),
                    );
                  });
            } else if (!snapshot.hasData && snapshot.data == null) {
              return Container(
                width: 10,
                height: 10,
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
