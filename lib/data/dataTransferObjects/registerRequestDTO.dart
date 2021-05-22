import 'package:json_annotation/json_annotation.dart';

part "registerRequestDTO.g.dart";

@JsonSerializable()
class RegisterRequestDTO {
  String names;
  String lastName;
  String emailAddress;
  int userType;
  String password;
  String stateId;

  RegisterRequestDTO(
      {this.names,
      this.lastName,
      this.emailAddress,
      this.userType,
      this.password,
      this.stateId});

  factory RegisterRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestDTOToJson(this);
}
