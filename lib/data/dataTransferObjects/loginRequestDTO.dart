import 'package:json_annotation/json_annotation.dart';

part "loginRequestDTO.g.dart";

@JsonSerializable()
class LoginRequestDTO {
  final String emailAddress;
  final String password;

  LoginRequestDTO({this.emailAddress, this.password});

  factory LoginRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestDTOToJson(this);
}
