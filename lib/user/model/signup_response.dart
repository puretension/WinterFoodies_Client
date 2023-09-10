import 'package:json_annotation/json_annotation.dart';

part 'signup_response.g.dart';

@JsonSerializable()
class SignupResponse {
  final String username;
  final String nickname;

  SignupResponse({
    required this.username,
    required this.nickname,
  });
  factory SignupResponse.fromJson(Map<String, dynamic> json)
  => _$SignupResponseFromJson(json);
}