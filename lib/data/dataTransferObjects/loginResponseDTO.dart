import 'package:json_annotation/json_annotation.dart';

part "loginResponseDTO.g.dart";

@JsonSerializable()
class LoginResponseDTO {
  final String id;
  final String userId;
  final String names;
  final String lastName;
  final String emailAddress;
  final int userType;
  final bool verified;
  final String stateId;
  final String token;
  final String refreshToken;

  LoginResponseDTO(
      this.id,
      this.names,
      this.lastName,
      this.emailAddress,
      this.userType,
      this.verified,
      this.stateId,
      this.token,
      this.userId,
      this.refreshToken);

  factory LoginResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDTOToJson(this);
}
