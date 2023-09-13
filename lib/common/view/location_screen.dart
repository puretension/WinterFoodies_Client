import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:winter_foodies/location/model/location_model.dart';
import 'package:http/http.dart' as http;

class LocationScreen extends StatefulWidget {
  final Function(LatLng, String) onLocationUpdate;

  const LocationScreen({Key? key, required this.onLocationUpdate}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  LatLng currentLatLng = LatLng(37.5665, 126.9780);  // no longer nullable
  late GoogleMapController mapController;
  String? currentAddress;


  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }
  static Future<String> getPlaceAddress(double lat, double lng) async{
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&language=ko&key=AIzaSyBF6vHW7S9rO17wZo_ooVCgFKyCx29VUAg';
    final resp = await http.get(Uri.parse(url)); // Dart version 2.12 이상에서는 `Uri.parse`를 사용해야 합니다.

    return jsonDecode(resp.body)['results'][0]['formatted_address'];
  }


  Future<geo.Position?> getCurrentLocation() async {
    try {
      geo.Position position = await geo.Geolocator.getCurrentPosition(
          desiredAccuracy: geo.LocationAccuracy.high
      );
      String address = await getPlaceAddress(position.latitude, position.longitude);
      setState(() {
        currentAddress = address;
      });

      // 위치 정보와 주소를 callback을 통해 반환
      widget.onLocationUpdate(LatLng(position.latitude, position.longitude), address);

      return position;
    } catch (e) {
      print("Geolocator error: $e");
      return null;
    }
  }


  _moveToCurrentLocation() {
    mapController.animateCamera(CameraUpdate.newLatLngZoom(currentLatLng!, 15));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: currentLatLng,  // default location
            zoom: 15,
          ),
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
            if (currentLatLng != null) {
              _moveToCurrentLocation();
            }
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var gps = await getCurrentLocation();
          mapController.animateCamera(CameraUpdate.newLatLng(LatLng(gps!.latitude, gps!.longitude)));
        },
        child: Icon(
          Icons.my_location,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
