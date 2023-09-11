

import 'package:flutter/material.dart';
import 'package:winter_foodies/location/model/location_model.dart';

class LocationProvider extends InheritedWidget {
  final LocationModel location;

  LocationProvider({
    Key? key,
    required this.location,
    required Widget child,
  }) : super(key: key, child: child);

  static LocationModel? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LocationProvider>()?.location;
  }

  @override
  bool updateShouldNotify(covariant LocationProvider oldWidget) {
    return oldWidget.location != location;
  }
}
