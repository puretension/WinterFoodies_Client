import 'package:json_annotation/json_annotation.dart';
import 'package:winter_foodies/user/model/user_model.dart';

part 'signup_user_model.g.dart';

@JsonSerializable()
class SignupUserModel{
  final String username;
  final String nickname;
  final String password;
  final String confirmPassword;
  final String phoneNumber;



  SignupUserModel({
    required this.username,
    required this.nickname,
    required this.password,
    required this.phoneNumber,
    required this.confirmPassword,
  });

  SignupUserModel copyWith({
    String? password,
    String? confirmPassword,
    String? nickname,
    String? phoneNumber,
    String? username,
  }) {
    return SignupUserModel(
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      nickname: nickname ?? this.nickname,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      username: username ?? this.username,
    );
  }

  factory SignupUserModel.fromJson(Map<String, dynamic> json) =>
      _$SignupUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignupUserModelToJson(this);
}
