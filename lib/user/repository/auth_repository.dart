import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:winter_foodies/common/const/data.dart';
import 'package:winter_foodies/common/dio/dio.dart';
import 'package:winter_foodies/common/model/login_response.dart';
import 'package:winter_foodies/user/model/check_response.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(baseUrl: 'http://$ip/api', dio: dio);
});

class AuthRepository {
  //baseUrl == http://$ip/auth
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.baseUrl,
    required this.dio,
  });

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final body = {
      'username': username,
      'password': password,
    };

    final resp = await dio.post(
      '$baseUrl/login',
      data: body,
    );

    return LoginResponse.fromJson(
      resp.data,
    );
  }

  Future<CheckResponse> checkEmail(String username) async {
    final resp = await dio.get('$baseUrl/check-username/$username');
    return CheckResponse.fromJson(resp.data);
  }



// Future<LoginResponse> login({
  //   required String username,
  //   required String password,
  // }) async {
  //   final serialized = DataUtils.plainToBase64('$username:$password');
  //
  //   final resp = await dio.post(
  //     '$baseUrl/login',
  //     options: Options(
  //       headers: {
  //         'authorization': 'Basic $serialized',
  //       },
  //     ),
  //   );
  //   return LoginResponse.fromJson(
  //     resp.data,
  //   );
  // }

  // Future<TokenResponse> token() async {
  //   final resp = await dio.post(
  //     '$baseUrl/token',
  //     options: Options(
  //       headers: {
  //         'refreshToken': 'true',
  //       },
  //     ),
  //   );
  //   return TokenResponse.fromJson(
  //     resp.data,
  //   );
  // }
}
