// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_response_dto_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreResponseDtoList _$StoreResponseDtoListFromJson(
        Map<String, dynamic> json) =>
    StoreResponseDtoList(
      json['storeId'] as int,
      json['name'] as String,
      json['latitude'] as String,
      json['longitude'] as String,
      DataUtils.pathToUrl(json['thumbNailImgUrl'] as String),
    );

Map<String, dynamic> _$StoreResponseDtoListToJson(
        StoreResponseDtoList instance) =>
    <String, dynamic>{
      'storeId': instance.storeId,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'thumbNailImgUrl': instance.thumbNailImgUrl,
    };
