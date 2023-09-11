import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:winter_foodies/common/const/data.dart';
import 'package:winter_foodies/common/dio/dio.dart';
import 'package:winter_foodies/common/storage/secure_storage.dart';
import 'package:winter_foodies/user/model/signup_response.dart';
import 'package:winter_foodies/user/model/signup_user_model.dart';
import 'package:winter_foodies/user/model/user_model.dart';
import 'package:winter_foodies/user/repository/auth_repository.dart';
import 'package:winter_foodies/user/repository/user_me_repository.dart';

final userMeProvider =
StateNotifierProvider<UserMeStateNotifier, UserModelBase?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userMeRepository = ref.watch(userMeRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);
  final dio = ref.watch(dioProvider);

  return UserMeStateNotifier(
    authRepository: authRepository,
    repository: userMeRepository,
    storage: storage,
    dio: dio,
    ref: ref, //getMe로 받은걸 뿌려주기 위함
  );
});

//로그아웃 되었다면 null들어가게끔 UserModelBase?
class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final UserMeRepository repository;
  final FlutterSecureStorage storage;
  final AuthRepository authRepository;
  final Dio dio;
  final Ref ref; // ProviderReference 인스턴스

  UserMeStateNotifier({
    required this.authRepository,
    required this.repository,
    required this.storage,
    required this.dio,
    required this.ref,
  }) : super(UserModelLoading()) {
    //유저 정보 바로 가져 오기
    logout();
    getMe();
  }

  // // UserMeStateNotifier 클래스 내부에 추가
  // Future<void> changePassword(PasswordChangeModel passwordChangeModel) async {
  //   try {
  //     // 저장된 액세스 토큰을 가져옵니다.
  //     final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
  //
  //
  //     if (accessToken == null) {
  //       print('잘못된 접근입니다.');
  //       return;
  //     }
  //
  //     final changeResp = await repository.changePassword(passwordChangeModel: passwordChangeModel);
  //
  //     print(passwordChangeModel.checkPassword);
  //
  //     getMe();
  //   } catch (e) {
  //     // 비밀번호 변경에 실패한 경우의 로직 (예: 에러 메시지 표시 등)
  //   }
  // }


  Future<void> getMe() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    print('accessToken: $accessToken');

    // //refreshToken이 만료된게 아니라면 -> 강제 로그아웃(이대로하면 너무 자주로그아웃됨)
    // if (accessToken == null) {
    //   state = null; //토큰이 2중 1개라도 없다면 로그아웃
    //   return;
    // }

    final resp = await repository.getMe();
    state = resp;
  }

  // UserModeBase를 반환타입으로 한 이유는 3가지 경우때문
  // 1. 정상 로그인
  // 2. 로그인이 안될수도 있음
  // 3. 로딩중
  Future<UserModelBase> login({
    required String username,
    required String password,
  }) async {
    try {
      state = UserModelLoading();

      final resp = await authRepository.login(
        username: username,
        password: password,
      );

      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);

      print('accessToken with login: ${resp.accessToken}');

      final userResp = await repository.getMe();

      state = userResp;

      return userResp;
    } catch (e) {
      //ID잘못이다, PW잘못이다 세부작업 필요 ->  Repository 수정필요
      state = UserModelError(message: '로그인에 실패했습니다');

      return Future.value(state);
    }
  }

  Future<SignupResponse> postUser(SignupUserModel signupUserModel) async {
    try {
      state = UserModelLoading();

      // 1. 회원가입 POST
      final userResp = await repository.postUser(signupUserModel);

      // 딜레이 추가: 2초 동안 대기
      await Future.delayed(Duration(seconds: 2));

      // 4. 최종 결과 반환
      return userResp;

    } catch (e) {
      print('Hallo');
      state = UserModelError(message: '회원가입에 실패했습니다');
      return Future.error(UserModelError(message: '회원가입에 실패했습니다'));
    }
  }


  Future<void> logout() async {
    state = null;
    Future.wait([
      storage.delete(key: ACCESS_TOKEN_KEY),
    ]);
    // try {
    //   final logoutResp = await repository.logout();
    // } catch(e){
    //   print('로그아웃 실패');
    // }
  }
}