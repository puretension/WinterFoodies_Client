
import 'package:json_annotation/json_annotation.dart';

part 'product_response_dto_list.g.dart';

@JsonSerializable()
class ProductResponseDtoList {
  final int id;
  final String productName;

  ProductResponseDtoList(this.id, this.productName);

  factory ProductResponseDtoList.fromJson(Map<String, dynamic> json)
  => _$ProductResponseDtoListFromJson(json);

  Map<String,dynamic> toJson() => _$ProductResponseDtoListToJson(this);
}
