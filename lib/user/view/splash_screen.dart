import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:winter_foodies/common/const/colors.dart';
import 'package:winter_foodies/user/layout/default_layout.dart';

class SplashScreen extends ConsumerWidget {
  static String get routeName => 'splash';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      backgroundColor: Colors.white,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: PRIMARY_BROWN_COLOR,
            ),
          ],
        ),
      ),
    );
  }
}
