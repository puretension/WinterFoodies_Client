// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckResponse _$CheckResponseFromJson(Map<String, dynamic> json) =>
    CheckResponse(
      message: json['message'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$CheckResponseToJson(CheckResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
    };
