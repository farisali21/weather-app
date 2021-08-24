import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_weather_app/bottomSheet.dart';
import 'package:new_weather_app/network_helper/data_service.dart';

import 'network_helper/models.dart';

class MapSample extends StatefulWidget {
  final Position position;
  final WeatherResponce responce;

  const MapSample({Key? key, required this.position, required this.responce})
      : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late Marker _origin;
  final serviceLocation = DataService();
  WeatherResponce? temp;

  @override
  void initState() {
    super.initState();
    _locationMarker(
        LatLng(widget.position.latitude, widget.position.longitude));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              markers: {
                _origin,
              },
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target:
                    LatLng(widget.position.latitude, widget.position.longitude),
                zoom: 14.4746,
              ),
              onTap: (result) async {
                _addMarker(result);
                temp = await serviceLocation.getCurrrentLocationWeather(
                    result.latitude.toString(), result.longitude.toString());
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: Container(
              padding: EdgeInsets.all(15),
              color: Color(0xff757575),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Select your city....'),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      temp == null
                          ? CircularProgressIndicator()
                          : showModalBottomSheet(
                              context: context,
                              builder: (context) => BottomSheetTemp(
                                    temp: temp!,
                                  ));
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _locationMarker(LatLng pos) {
    setState(() {
      _origin = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: InfoWindow(title: widget.responce.tempInfo.temp.toString()),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: pos,
      );
    });
  }

  void _addMarker(LatLng pos) {
    setState(() {
      _origin = Marker(
        markerId: MarkerId('origin'),
        infoWindow: InfoWindow(title: 'Origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: pos,
      );
    });
  }
}

/*
Container(
            color: Color(0xff757575),
            child: Row(
              children: [
                Text('Select your city....'),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => BottomSheetTemp(
                              temp: temp,
                            ));
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ),
*/