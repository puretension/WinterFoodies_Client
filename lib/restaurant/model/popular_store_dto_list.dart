
import 'package:json_annotation/json_annotation.dart';

part 'popular_store_dto_list.g.dart';

@JsonSerializable()
class PopularStoreDtoList{
  final int storeId;
  final String name;
  final String basicAddress;
  final int averageRating;
  final int orders;
  final double latitude;
  final double longitude;

  PopularStoreDtoList(this.storeId,this.name,this.basicAddress,this.averageRating,this.orders,this.latitude,this.longitude);

  factory PopularStoreDtoList.fromJson(Map<String, dynamic> json)
  => _$PopularStoreDtoListFromJson(json);

  Map<String,dynamic> toJson() => _$PopularStoreDtoListToJson(this);
}
