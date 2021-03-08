import 'package:flutter/material.dart';
import 'package:weather/app/controllers/weather.bloc.dart';
import 'package:weather/app/infrastructure/metaweather.client.dart';
import 'package:weather/app/models/consolidate-weather.model.dart';
import 'package:weather/app/models/location.model.dart';

class WeatherDisplayView extends StatefulWidget {
  @override
  _WeatherDisplayViewState createState() => _WeatherDisplayViewState();
}

class _WeatherDisplayViewState extends State<WeatherDisplayView> {
  var _controller;

  @override
  void initState() {
    super.initState();
    _controller = new WeatherBloc(new MetaWeatherClient());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Previsão do tempo"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                StreamBuilder(
                    stream: _controller.allAvailableCities,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return citiesList(snapshot.data);
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                SizedBox(height: 30),
                Container(
                  height: 200,
                  child: StreamBuilder(
                      stream: _controller.allPredictsWeather,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  snapshot.data.consolidatedWeather.length,
                              itemBuilder: (context, index) {
                                return _showWeatherPrediction(
                                    snapshot.data.consolidatedWeather[index]);
                              });
                        }

                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget citiesList(List<LocationModel> data) {
    return DropdownButtonFormField(
        onChanged: (value) {
          _controller.fetchCityInformationByName(value);
        },
        items: data.map<DropdownMenuItem<String>>((LocationModel value) {
          return DropdownMenuItem<String>(
            value: value.name,
            child: Text(value.name),
          );
        }).toList());
  }

  Widget _showWeatherPrediction(ConsolidatedWeather weather) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 200,
      child: Card(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(_controller
              .getIconFromWeatherCondition(weather.weatherStateName)),
          Text(weather.applicableDate),
          Text(weather.weatherStateName),
        ]),
      ),
    );
  }
}
