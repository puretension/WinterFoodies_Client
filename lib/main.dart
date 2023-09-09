import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_core/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:winter_foodies/common/const/colors.dart';
import 'package:winter_foodies/common/view/select_screen.dart'; // 다언어 설정

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) => MaterialApp(
        theme: ThemeData(
          fontFamily: 'GmarketSans',
        ),
        debugShowCheckedModeBanner: false,
        home: SelectScreen(), // 기본 화면을 설정하거나 이 부분을 수정해주세요.
        localizationsDelegates: const [  // 다언어 설정
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''), // English
          const Locale('ko', ''), // Korean
        ],
      ),
    );
  }
}






// class MyApp extends ConsumerWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final route = ref.watch(routeProvider);
//     return ScreenUtilInit(
//       designSize: Size(375, 812),
//       builder: (context, child) => MaterialApp.router(
//         debugShowCheckedModeBanner: false,
//         routerConfig: route,
//         localizationsDelegates: const [  // 다언어 설정
//           GlobalMaterialLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//           GlobalCupertinoLocalizations.delegate,
//         ],
//         supportedLocales: [
//           const Locale('en', ''), // English
//           const Locale('ko', ''), // Korean
//         ],
//       ),
//     );
//   }
// }