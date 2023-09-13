// import 'package:flutter/material.dart';
// import 'package:flutter_naver_map/flutter_naver_map.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
// class LocationScreen extends StatefulWidget {
//   const LocationScreen({super.key});
//
//   @override
//   _LocationScreenState createState() => _LocationScreenState();
// }
//
// class _LocationScreenState extends State<LocationScreen> {
//   LatLng? _currentLocation;
//   final _locationService = Location();
//
//   @override
//   void initState() {
//     print(_currentLocation);
//     _getCurrentLocation();
//     super.initState();
//   }
//
//   _getCurrentLocation() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;
//
//     serviceEnabled = await _locationService.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await _locationService.requestService();
//       if (!serviceEnabled) {
//         return;
//       }
//     }
//
//     permissionGranted = await _locationService.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await _locationService.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//
//     final locationData = await _locationService.getLocation();
//     print(locationData);
//     setState(() {
//       _currentLocation =
//           LatLng(locationData.latitude!, locationData.longitude!);
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_currentLocation == null) {
//       return Center(child: CircularProgressIndicator()); // 위치 정보가 없으면 로딩 표시
//     }
//     print('he');
//     return Scaffold(
//       body: NaverMap(
//         options: NaverMapViewOptions(
//           initialCameraPosition: NCameraPosition(
//             target: NLatLng(_currentLocation!.latitude, _currentLocation!.longitude),
//             zoom: 10,
//             bearing: 0,
//             tilt: 0,
//           ),
//         ), // 현재 위치로 지도의 중심을 설정
//         // ... 나머지 코드
//       ),
//     );
//   }
// }
