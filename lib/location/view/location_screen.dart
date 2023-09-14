import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:winter_foodies/location/provider/location_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationScreen extends ConsumerWidget {
  final Function(LatLng, String) onLocationUpdate;

  const LocationScreen({Key? key, required this.onLocationUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationProvider);

    LatLng currentLatLng = locationState.location != null
        ? LatLng(locationState.location!.latitude, locationState.location!.longitude)
        : LatLng(37.5665, 126.9780);

    String? currentAddress = locationState.address;

    // GoogleMapController를 저장하는 변수를 선언
    late GoogleMapController mapController;

    // 사용자의 현재 위치로 지도를 이동하는 메서드
    void _moveToCurrentLocation() {
      if (locationState.location != null) {
        mapController.animateCamera(CameraUpdate.newLatLngZoom(currentLatLng, 15));
      }
    }

    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: currentLatLng,
          zoom: 15,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
          _moveToCurrentLocation();
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print(locationState.address);
          ref.read(locationProvider.notifier).getCurrentLocation();
          _moveToCurrentLocation();  // 버튼을 클릭하면 현재 위치로 지도를 이동합니다.
          if (locationState.location != null) {
            LatLng gps = LatLng(locationState.location!.latitude, locationState.location!.longitude);
            onLocationUpdate(gps, locationState.address!);
          }
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
