
import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel {
  final double latitude;
  final double longitude;

  LocationModel(this.latitude, this.longitude);

  factory LocationModel.fromJson(Map<String, dynamic> json)
  => _$LocationModelFromJson(json);

  Map<String,dynamic> toJson() => _$LocationModelToJson(this);
}
