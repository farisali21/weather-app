import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:new_weather_app/get_location.dart';
import 'package:new_weather_app/home.dart';
import 'package:new_weather_app/network_helper/data_service.dart';

class Setting extends StatelessWidget {
  final _dataService = DataService();

  @override
  Widget build(BuildContext context) {
    final _location = Location();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          final postion = await _location.getCurrentPosition();
          final responce = await _dataService.getCurrrentLocationWeather(
            postion.latitude.toString(),
            postion.longitude.toString(),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomeScreen(
                  responce: responce,
                  position: postion,
                );
              },
            ),
          );
        },
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text('u should get location permission'),
                ),
                ElevatedButton(
                  onPressed: Geolocator.openAppSettings,
                  child: Text('Setting'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
