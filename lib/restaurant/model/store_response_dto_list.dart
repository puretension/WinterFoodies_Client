



import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:winter_foodies/common/utils/data_utils.dart';

part 'store_response_dto_list.g.dart';

@JsonSerializable()
class StoreResponseDtoList {
  final double? storeId;
  final String? name;
  final double? latitude;
  final double? longitude;
  // @JsonKey(
  //   fromJson: DataUtils.pathToUrl,
  // )
  final String? thumbNailImgUrl;

  StoreResponseDtoList(this.storeId, this.name, this.latitude, this.longitude, this.thumbNailImgUrl);

  factory StoreResponseDtoList.fromJson(Map<String, dynamic> json)
  => _$StoreResponseDtoListFromJson(json);

  Map<String,dynamic> toJson() => _$StoreResponseDtoListToJson(this);
}
