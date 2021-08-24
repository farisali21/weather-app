class WeatherInfo {
  final String description;

  WeatherInfo({required this.description});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    return WeatherInfo(description: description);
  }
}

class TemperatureInfo {
  final double temp;
  TemperatureInfo({required this.temp});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temp = json['temp'];
    return TemperatureInfo(temp: temp);
  }
}

class WeatherResponce {
  final String cityName;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;
  WeatherResponce(
      {required this.cityName,
      required this.tempInfo,
      required this.weatherInfo});

  factory WeatherResponce.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final tempInfoJson = json['main'];
    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);

    return WeatherResponce(
      cityName: cityName,
      tempInfo: tempInfo,
      weatherInfo: weatherInfo,
    );
  }
}



/*                          

{
  "weather": [
    {
      "description": "clear sky",
    }
  ],
  "main": {
    "temp": 282.55,
  },
  "name": "Mountain View",
}
  */