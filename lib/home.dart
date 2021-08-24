import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:new_weather_app/get_city_weather.dart';
import 'package:new_weather_app/google_map.dart';

import 'network_helper/data_service.dart';
import 'network_helper/models.dart';

class HomeScreen extends StatefulWidget {
  final WeatherResponce responce;
  final Position position;
  const HomeScreen({
    Key? key,
    required this.responce,
    required this.position,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MapSample(
                        position: widget.position, responce: widget.responce),
                  ),
                );
              },
              icon: Icon(Icons.map),
              label: Text('Map'))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CityWeather()));
              },
              child: Icon(Icons.location_city),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              '${widget.responce.tempInfo.temp}',
              style: TextStyle(fontSize: 40),
            ),
            Text(widget.responce.weatherInfo.description),
          ],
        ),
      ),
    );
  }
}
