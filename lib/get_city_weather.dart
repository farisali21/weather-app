import 'package:flutter/material.dart';

import 'network_helper/data_service.dart';
import 'network_helper/models.dart';

class CityWeather extends StatefulWidget {
  const CityWeather({Key? key}) : super(key: key);

  @override
  _CityWeatherState createState() => _CityWeatherState();
}

class _CityWeatherState extends State<CityWeather> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();
  WeatherResponce? _responce;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (_responce != null)
                FutureBuilder(
                  builder: (context, snapshot) => Column(
                    children: [
                      Text(
                        '${_responce!.tempInfo.temp}',
                        style: TextStyle(fontSize: 40),
                      ),
                      Text(_responce!.weatherInfo.description),
                    ],
                  ),
                ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: SizedBox(
                  width: 150,
                  child: TextField(
                      controller: _cityTextController,
                      decoration: InputDecoration(labelText: 'City'),
                      textAlign: TextAlign.center),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _search();
                },
                child: Text('Search'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _search() async {
    final responce =
        await _dataService.getCityWeather(_cityTextController.text);
    setState(() => _responce = responce);
  }

  Widget circularProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
