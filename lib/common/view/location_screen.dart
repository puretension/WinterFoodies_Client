import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:winter_foodies/location/model/location_model.dart';


class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  LatLng currentLatLng = LatLng(37.5665, 126.9780);  // no longer nullable
  late GoogleMapController mapController;

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  Future<geo.Position?> getCurrentLocation() async {  // 반환 타입을 Future<geo.Position?>로 변경
    try {
      geo.Position position = await geo.Geolocator.getCurrentPosition(
          desiredAccuracy: geo.LocationAccuracy.high
      );
      setState(() {
        currentLatLng = LatLng(position.latitude, position.longitude);
      });
      return position;  // Position 반환
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
