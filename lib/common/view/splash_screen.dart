import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winter_foodies/common/const/colors.dart';
import 'package:winter_foodies/user/layout/default_layout.dart';

// class SplashScreenOverlay extends StatefulWidget {
//   final Widget child; // 기존 위젯을 받아오기 위한 변수
//
//   SplashScreenOverlay({required this.child});
//
//   @override
//   _SplashScreenOverlayState createState() => _SplashScreenOverlayState();
// }
//
// class _SplashScreenOverlayState extends State<SplashScreenOverlay> {
//   int _currentImageIndex = 1;
//
//   @override
//   void initState() {
//     super.initState();
//     _changeLoadingImage();
//   }
//
//   _changeLoadingImage() async {
//     await Future.delayed(Duration(seconds: 1), () {
//       if (mounted) {
//         setState(() {
//           _currentImageIndex++;
//           if (_currentImageIndex > 3) _currentImageIndex = 1; // 이미지를 1부터 다시 시작
//         });
//         _changeLoadingImage();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         widget.child, // 기존 위젯
//         Container(
//           color: Colors.black.withOpacity(0.7),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset('asset/img/loading$_currentImageIndex.png'),
//                 SizedBox(height: 16.0),
//                 CircularProgressIndicator(color: Colors.white),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
//


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String get routeName => 'splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _currentImageIndex = 1;
  late OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();
    _changeLoadingImage();
    _showOverlay(context);
  }

  _changeLoadingImage() async {
    await Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _currentImageIndex++;
          if (_currentImageIndex > 3) _currentImageIndex = 1; // 이미지를 1부터 다시 시작
        });
        _changeLoadingImage();
      }
    });
  }

  _showOverlay(BuildContext context) {
    overlayEntry = OverlayEntry(
      builder: (context) => _buildOverlayContent(),
    );
    Overlay.of(context).insert(overlayEntry);
  }

  _removeOverlay() {
    overlayEntry.remove();
  }

  Widget _buildOverlayContent() {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('asset/img/loading$_currentImageIndex.png'),
            SizedBox(height: 16.0),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // 실제 화면은 overlay 위에 그려집니다.
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }
}
