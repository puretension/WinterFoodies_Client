import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:winter_foodies/common/const/colors.dart';
import 'package:winter_foodies/common/view/home_screen.dart';
import 'package:winter_foodies/common/view/location_screen.dart';
import 'package:winter_foodies/location/model/location_model.dart';
import 'package:winter_foodies/location/view/location_screen.dart';
import 'package:winter_foodies/my_page/view/my_page_screen.dart';
import 'package:winter_foodies/order/order_screen.dart';
import 'package:winter_foodies/user/layout/default_layout.dart';
import 'package:location/location.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'home';
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;
  LatLng? currentLatLng;
  String? currentAddress;


  int index = 0;

  LocationModel? locationModel;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 4, vsync: this);

    controller.addListener(tabListener);
  }


  @override
  void dispose() {
    controller.removeListener(tabListener);

    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(address: currentAddress,onRefresh: (){}),
          LocationScreen(onLocationUpdate: (latLng, address) {
            setState(() {
              currentLatLng = latLng;
              currentAddress = address;
            });
          }),
          OrderScreen(),
          MyPageScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_BROWN_COLOR,
        unselectedItemColor: Colors.black,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: '내주변',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '장바구니',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '마이푸디',
          ),
        ],
      ),
    );
  }
}
