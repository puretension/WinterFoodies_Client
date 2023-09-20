



import 'package:json_annotation/json_annotation.dart';
import 'package:winter_foodies/common/utils/data_utils.dart';

part 'store_response_dto_list.g.dart';

@JsonSerializable()
class StoreResponseDtoList {
  final int storeId;
  final String name;
  final String latitude;
  final String longitude;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String thumbNailImgUrl;

  StoreResponseDtoList(this.storeId, this.name, this.latitude, this.longitude, this.thumbNailImgUrl);

  factory StoreResponseDtoList.fromJson(Map<String, dynamic> json)
  => _$StoreResponseDtoListFromJson(json);

  Map<String,dynamic> toJson() => _$StoreResponseDtoListToJson(this);
}
