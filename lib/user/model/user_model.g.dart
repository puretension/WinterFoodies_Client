// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      nickname: json['nickname'] as String,
      phoneNumber: json['phoneNumber'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'nickname': instance.nickname,
      'phoneNumber': instance.phoneNumber,
      'username': instance.username,
    };
