import 'package:geolocator/geolocator.dart';

class Location {
  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition();
  }

  Future<bool> handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  // Future<void> getLocationData(BuildContext context) async {
  //   final hasPermission = await handlePermission();

  //   if (hasPermission) {
  //     final postion = await getCurrentPosition();
  //     final responce = await _dataService.getCurrrentLocationWeather(
  //       postion.latitude.toString(),
  //       postion.longitude.toString(),
  //     );
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) {
  //           return HomeScreen(
  //             responce: responce,
  //           );
  //         },
  //       ),
  //     );
  //   } else {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) {
  //           return Setting();
  //         },
  //       ),
  //     );
  //   }
  // }
}
