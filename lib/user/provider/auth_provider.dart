import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:winter_foodies/user/model/user_model.dart';
import 'package:winter_foodies/user/provider/user_me_provider.dart';
import 'package:winter_foodies/common/view/root_tab.dart';
import 'package:winter_foodies/user/view/login_screen.dart';
import 'package:winter_foodies/user/view/select_screen.dart';
import 'package:winter_foodies/user/view/signup_screen.dart';
import 'package:winter_foodies/user/view/splash_screen.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(
      userMeProvider,
      (previous, next) {
        if (previous != next) {
          notifyListeners();
        }
      },
    );
  }

  List<GoRoute> get routes => [
        // 명심하자 -
        // /는 루트 경로로 인식된다
        //'interview' 아래에 ':rid'를 붙였을 때의 경로는 /interview/:rid 자동으로 /가 추가된다
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (_, __) => RootTab(),
          routes: [
            // GoRoute(
            //   path: 'research',
            //   name: ResearchScreen.routeName,
            //   builder: (_, state) => ResearchScreen(),
            //   routes: [ // InterviewScreen 아래에 nested route로 DetailScreen 설정
            //     GoRoute(
            //       path: ':id',
            //       name: ResearchDetailScreen.routeName,
            //       builder: (_, state) =>
            //           ResearchDetailScreen(id: state.pathParameters['id']!),
            //     ),
            //   ],
            // ),
            // GoRoute(
            //   path: 'noti',
            //   name: NoticeScreen.routeName,
            //   builder: (_, state) => NoticeScreen(),
            //   routes: [ // InterviewScreen 아래에 nested route로 DetailScreen 설정
            //     GoRoute(
            //       path: ':id',
            //       name: NoticeDetailScreen.routeName,
            //       builder: (_, state) =>
            //           NoticeDetailScreen(id: state.pathParameters['id']!),
            //     ),
            //   ],
            // ),
            // GoRoute(
            //   path: 'report',
            //   name: UserReportScreen.routeName,
            //   builder: (_, state) => UserReportScreen(),
            //   routes: [ // InterviewScreen 아래에 nested route로 DetailScreen 설정
            //     GoRoute(
            //       path: ':id',
            //       name: ReportDetailScreen.routeName,
            //       builder: (_, state) =>
            //           ReportDetailScreen(id: state.pathParameters['id']!),
            //     ),
            //   ],
            // ),
          ],
        ),
        GoRoute(
          path: '/signup',
          name: SignupScreen.routeName,
          builder: (_, state) => SignupScreen(),
          //restaurantScreen의 goNamed와 연결
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_, __) => SplashScreen(),
        ),
        GoRoute(
          path: '/select',
          name: SelectScreen.routeName,
          builder: (_, __) => SelectScreen(),
        ),

        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (_, __) => LoginScreen(),
        ),
        // GoRoute(
        //   path: '/request',
        //   name: ResearchReqScreen.routeName,
        //   builder: (_, __) => ResearchReqScreen(),
        // ),
        // GoRoute(
        //   path: '/notiRequest',
        //   name: NotiReqScreen.routeName,
        //   builder: (_, __) => NotiReqScreen(),
        // ),
      ];

  logout() {
    ref.read(userMeProvider.notifier).logout();
    notifyListeners();
  }

  FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);


    print(state.matchedLocation);

    if(user is UserModelLoading){
      return '/splash';
    }

    if (user is! UserModel) {
      return '/select';
    }

    print('hall');
    if (user is UserModel && (state.matchedLocation == '/select' ||
        state.matchedLocation == '/login' ||
        state.matchedLocation == '/splash')) {
      return '/';
    }

    return null;
  }


// FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
//   final UserModelBase? user = ref.read(userMeProvider);
//
//   if ((state.matchedLocation == '/signup' || state.matchedLocation == '/login') && user is UserModel)
//     return '/';
//
//   if (state.matchedLocation.startsWith('/signup')) return null;
//
//   if (state.matchedLocation == '/login' && user is UserModel) return '/';
//
//   if (!state.matchedLocation.startsWith('/login') && user == null) return '/select';
//
//   if (user is UserModel &&
//       (state.matchedLocation == '/select'
//           || state.matchedLocation == '/splash')) return '/';
//
//   return null;
// }
}
