// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
//   return AuthProvider(ref: ref);
// });
//
// class AuthProvider extends ChangeNotifier {
//   final Ref ref;
//
//   AuthProvider({
//     required this.ref,
//   }) {
//     ref.listen<UserModel?>(
//       userMeProvider,
//           (previous, next) {
//         if (previous != next) {
//           notifyListeners();
//         }
//       },
//     );
//   }
//
//   List<GoRoute> get routes => [
//     // 명심하자 -
//     // /는 루트 경로로 인식된다
//     //'interview' 아래에 ':rid'를 붙였을 때의 경로는 /interview/:rid 자동으로 /가 추가된다
//     GoRoute(
//       path: '/',
//       name: RootTab.routeName,
//       builder: (_, __) => RootTab(),
//       routes: [
//         GoRoute(
//           path: 'research',
//           name: ResearchScreen.routeName,
//           builder: (_, state) => ResearchScreen(),
//           routes: [ // InterviewScreen 아래에 nested route로 DetailScreen 설정
//             GoRoute(
//               path: ':id',
//               name: ResearchDetailScreen.routeName,
//               builder: (_, state) =>
//                   ResearchDetailScreen(id: state.pathParameters['id']!),
//             ),
//           ],
//         ),
//         GoRoute(
//           path: 'noti',
//           name: NoticeScreen.routeName,
//           builder: (_, state) => NoticeScreen(),
//           routes: [ // InterviewScreen 아래에 nested route로 DetailScreen 설정
//             GoRoute(
//               path: ':id',
//               name: NoticeDetailScreen.routeName,
//               builder: (_, state) =>
//                   NoticeDetailScreen(id: state.pathParameters['id']!),
//             ),
//           ],
//         ),
//         GoRoute(
//           path: 'report',
//           name: UserReportScreen.routeName,
//           builder: (_, state) => UserReportScreen(),
//           routes: [ // InterviewScreen 아래에 nested route로 DetailScreen 설정
//             GoRoute(
//               path: ':id',
//               name: ReportDetailScreen.routeName,
//               builder: (_, state) =>
//                   ReportDetailScreen(id: state.pathParameters['id']!),
//             ),
//           ],
//         ),
//       ],
//     ),
//     GoRoute(
//       path: '/signup1',
//       name: SignupScreenPage1.routeName,
//       builder: (_, state) => SignupScreenPage1(),
//       //restaurantScreen의 goNamed와 연결
//     ),
//     GoRoute(
//       path: '/signup2',
//       name: SignupScreenPage2.routeName,
//       builder: (_, state) => SignupScreenPage2(),
//       //restaurantScreen의 goNamed와 연결
//     ),
//     GoRoute(
//       path: '/signup3',
//       name: SignupScreenPage3.routeName,
//       builder: (_, state) => SignupScreenPage3(),
//       //restaurantScreen의 goNamed와 연결
//     ),
//
//     GoRoute(
//       path: '/splash',
//       name: SplashScreen.routeName,
//       builder: (_, __) => SplashScreen(),
//     ),
//     GoRoute(
//       path: '/select',
//       name: SelectScreen.routeName,
//       builder: (_, __) => SelectScreen(),
//     ),
//
//     GoRoute(
//       path: '/login',
//       name: LoginScreen.routeName,
//       builder: (_, __) => LoginScreen(),
//     ),
//     GoRoute(
//       path: '/request',
//       name: ResearchReqScreen.routeName,
//       builder: (_, __) => ResearchReqScreen(),
//     ),
//     GoRoute(
//       path: '/notiRequest',
//       name: NotiReqScreen.routeName,
//       builder: (_, __) => NotiReqScreen(),
//     ),
//   ];
//
//   logout() {
//     ref.read(userMeProvider.notifier).logout();
//     notifyListeners();
//   }
//
//   FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
//     final UserModelBase? user = ref.read(userMeProvider);
//
//     // 회원가입 페이지에서 회원가입 완료 후 로그인 페이지로 리다이렉트
//     if (state.matchedLocation == '/signup' && user is UserModel) return '/';
//
//     if (state.matchedLocation.startsWith('/signup')) return null;
//
//     if (state.matchedLocation == '/login' && user is UserModel) return '/';
//
//     if (!state.matchedLocation.startsWith('/login') && user == null) return '/select';
//
//     if (user is UserModel &&
//         (state.matchedLocation == '/select'
//             || state.matchedLocation == '/login' ||
//             state.matchedLocation == '/splash')) return '/';
//
//     // if (user is UserModelError) return '/select';
//
//     return null;
//   }
//
// // FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
// //   final UserModelBase? user = ref.read(userMeProvider);
// //
// //   if ((state.matchedLocation == '/signup' || state.matchedLocation == '/login') && user is UserModel)
// //     return '/';
// //
// //   if (state.matchedLocation.startsWith('/signup')) return null;
// //
// //   if (state.matchedLocation == '/login' && user is UserModel) return '/';
// //
// //   if (!state.matchedLocation.startsWith('/login') && user == null) return '/select';
// //
// //   if (user is UserModel &&
// //       (state.matchedLocation == '/select'
// //           || state.matchedLocation == '/splash')) return '/';
// //
// //   return null;
// // }
//
//
// }