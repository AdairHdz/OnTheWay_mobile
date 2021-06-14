import 'package:json_annotation/json_annotation.dart';

part "passwordRecoveryDTO.g.dart";

@JsonSerializable()
class PasswordRecoveryDTO {
  String emailAddress;
  String recoveryCode;
  String newPassword;

  PasswordRecoveryDTO(this.emailAddress, this.recoveryCode, this.newPassword);

  factory PasswordRecoveryDTO.fromJson(Map<String, dynamic> json) =>
      _$PasswordRecoveryDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordRecoveryDTOToJson(this);
}
