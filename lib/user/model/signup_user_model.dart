import 'package:json_annotation/json_annotation.dart';
import 'package:winter_foodies/user/model/user_model.dart';

part 'signup_user_model.g.dart';

@JsonSerializable()
class SignupUserModel{
  final bool checkNickName;
  final bool checkUserName;
  final String password;
  final String confirmPassword;
  final String nickname;
  final String phoneNumber;
  final String username;


  SignupUserModel({
    required this.checkNickName,
    required this.checkUserName,
    required this.nickname,
    required this.phoneNumber,
    required this.username,
    required this.password,
    required this.confirmPassword,
  });

  factory SignupUserModel.fromJson(Map<String, dynamic> json) =>
      _$SignupUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignupUserModelToJson(this);
}
