// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_store_dto_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularStoreDtoList _$PopularStoreDtoListFromJson(Map<String, dynamic> json) =>
    PopularStoreDtoList(
      json['storeId'] as int,
      json['name'] as String,
      json['basicAddress'] as String,
      json['averageRating'] as int,
      json['orders'] as int,
      (json['latitude'] as num).toDouble(),
      (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$PopularStoreDtoListToJson(
        PopularStoreDtoList instance) =>
    <String, dynamic>{
      'storeId': instance.storeId,
      'name': instance.name,
      'basicAddress': instance.basicAddress,
      'averageRating': instance.averageRating,
      'orders': instance.orders,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
