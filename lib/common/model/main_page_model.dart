import 'package:json_annotation/json_annotation.dart';
import 'package:winter_foodies/common/utils/data_utils.dart';
import 'package:winter_foodies/restaurant/model/popular_products_dto_list.dart';
import 'package:winter_foodies/restaurant/model/product_response_dto_list.dart';
import 'package:winter_foodies/restaurant/model/store_response_dto_list.dart';
import 'package:winter_foodies/restaurant/model/store_response_dto_list.dart';

part 'main_page_model.g.dart';

@JsonSerializable()
class MainPageModel {
  final String like;
  final List<ProductResponseDtoList> productResponseDtoList;
  final List<PopularProductsDtoList> popularProductsDtoList;
  final List<StoreResponseDtoList> storeResponseDtoList;

  MainPageModel(
    this.like,
    this.productResponseDtoList,
    this.popularProductsDtoList,
    this.storeResponseDtoList,
  );

  factory MainPageModel.fromJson(Map<String, dynamic> json) =>
      _$MainPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainPageModelToJson(this);
}
