import 'package:flutter/material.dart';
import 'package:weather/app/infrastructure/locator/locator.service.dart';
import 'package:weather/app/views/weather-display.view.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherDisplayView(),
    );
  }
}