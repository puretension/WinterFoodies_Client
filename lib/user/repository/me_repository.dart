import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:winter_foodies/common/const/data.dart';
import 'package:winter_foodies/common/dio/dio.dart';
import 'package:winter_foodies/user/model/signup_user_model.dart';
import 'package:winter_foodies/user/model/user_model.dart';

part 'me_repository.g.dart';

final userMeRepositoryProvider = Provider<UserMeRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return UserMeRepository(dio, baseUrl: 'http://$ip/api');
  },
);

// http://$ip/user/me
@RestApi()
abstract class UserMeRepository {
  factory UserMeRepository(Dio dio, {String baseUrl}) = _UserMeRepository;

  @GET('/me')
  @Headers({
    'accessToken': 'true',
  })
  Future<UserModel> getMe();

  @POST('/signup')
  Future<UserModel> postUser(@Body() SignupUserModel user);

}
