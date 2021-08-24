import 'package:flutter/material.dart';
import 'package:new_weather_app/get_location.dart';
import 'package:new_weather_app/home.dart';
import 'package:new_weather_app/setting.dart';

import 'network_helper/data_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  final _dataService = DataService();
  final _location = Location();
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  Future<void> getLocationData() async {
    final hasPermission = await _location.handlePermission();

    if (hasPermission) {
      final postion = await _location.getCurrentPosition();
      final responce = await _dataService.getCurrrentLocationWeather(
        postion.latitude.toString(),
        postion.longitude.toString(),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return HomeScreen(
              responce: responce,
              position: postion,
            );
          },
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Setting();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
