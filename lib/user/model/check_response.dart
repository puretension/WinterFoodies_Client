import 'package:json_annotation/json_annotation.dart';

part 'check_response.g.dart';

@JsonSerializable()
class CheckResponse {
  final String message;
  final String status;

  CheckResponse({
    required this.message,
    required this.status,
  });
  factory CheckResponse.fromJson(Map<String, dynamic> json)
  => _$CheckResponseFromJson(json);
}