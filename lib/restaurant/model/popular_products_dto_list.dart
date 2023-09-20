
import 'package:json_annotation/json_annotation.dart';

part 'popular_products_dto_list.g.dart';

@JsonSerializable()
class PopularProductsDtoList {
  final String productName;

  PopularProductsDtoList(this.productName);

  factory PopularProductsDtoList.fromJson(Map<String, dynamic> json)
  => _$PopularProductsDtoListFromJson(json);

  Map<String,dynamic> toJson() => _$PopularProductsDtoListToJson(this);
}
