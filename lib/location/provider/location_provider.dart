import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winter_foodies/common/const/data.dart';
import 'package:winter_foodies/location/model/location_model.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:http/http.dart' as http;

class LocationNotifier extends StateNotifier<LocationState> {
  LocationNotifier() : super(LocationState.initial()) {
    getCurrentLocation(); // 생성자에서 자동으로 위치 정보를 가져옵니다.
  }

  Future<String> _getPlaceAddress(double lat, double lng) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&language=ko&key=$GOOGLE_API_KEY';
    final resp = await http.get(Uri.parse(url));
    String fullAddress = jsonDecode(resp.body)['results'][0]['formatted_address'];

    // 주소를 공백으로 split
    List<String> addressParts = fullAddress.split(' ');

    if (addressParts.length >= 3) {
      // 주소의 앞 두 부분 (예: "대한민국", "서울특별시")를 제거
      addressParts.removeRange(0, 2);
      return addressParts.join(' ');  // 나머지 부분을 다시 합쳐서 반환
    } else {
      return fullAddress;  // 주소의 길이가 충분하지 않은 경우 원래 주소를 반환
    }
  }


  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    geo.LocationPermission permissionGranted;

    // 위치 서비스가 활성화되어 있는지 확인
    serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled.");
      return;
    }

    // 위치 권한 상태 확인
    permissionGranted = await geo.Geolocator.checkPermission();
    if (permissionGranted == geo.LocationPermission.denied) {
      permissionGranted = await geo.Geolocator.requestPermission();
      if (permissionGranted == geo.LocationPermission.denied) {
        print("Location permissions are denied.");
        return;
      }
    }

    if (permissionGranted == geo.LocationPermission.deniedForever) {
      print("Location permissions are permanently denied.");
      return;
    }


    try {
      geo.Position position = await geo.Geolocator.getCurrentPosition(
          desiredAccuracy: geo.LocationAccuracy.high
      );
      if (position != null) {
        String address = await _getPlaceAddress(position.latitude, position.longitude);

        state = LocationState(
            location: LocationModel(position.latitude, position.longitude),
            address: address
        );
      }
    } catch (e) {
      print("Geolocator error: $e");
    }
  }
}

class LocationState {
  final LocationModel? location;
  final String? address;

  LocationState({this.location, this.address});

  static LocationState initial() => LocationState();
}

final locationProvider = StateNotifierProvider<LocationNotifier, LocationState>((ref) {
  return LocationNotifier();
});
