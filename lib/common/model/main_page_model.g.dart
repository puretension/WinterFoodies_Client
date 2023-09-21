// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainPageModel _$MainPageModelFromJson(Map<String, dynamic> json) =>
    MainPageModel(
      json['like'] as String,
      (json['productResponseDtoList'] as List<dynamic>)
          .map(
              (e) => ProductResponseDtoList.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['popularProductsDtoList'] as List<dynamic>)
          .map(
              (e) => PopularProductsDtoList.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['storeResponseDtoList'] as List<dynamic>)
          .map((e) => StoreResponseDtoList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MainPageModelToJson(MainPageModel instance) =>
    <String, dynamic>{
      'like': instance.like,
      'productResponseDtoList': instance.productResponseDtoList,
      'popularProductsDtoList': instance.popularProductsDtoList,
      'storeResponseDtoList': instance.storeResponseDtoList,
    };
