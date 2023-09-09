// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupUserModel _$SignupUserModelFromJson(Map<String, dynamic> json) =>
    SignupUserModel(
      checkNickName: json['checkNickName'] as bool,
      checkUserName: json['checkUserName'] as bool,
      nickname: json['nickname'] as String,
      phoneNumber: json['phoneNumber'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
    );

Map<String, dynamic> _$SignupUserModelToJson(SignupUserModel instance) =>
    <String, dynamic>{
      'checkNickName': instance.checkNickName,
      'checkUserName': instance.checkUserName,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'nickname': instance.nickname,
      'phoneNumber': instance.phoneNumber,
      'username': instance.username,
    };
