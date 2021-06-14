// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passwordRecoveryDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordRecoveryDTO _$PasswordRecoveryDTOFromJson(Map<String, dynamic> json) {
  return PasswordRecoveryDTO(
    json['emailAddress'] as String,
    json['recoveryCode'] as String,
    json['newPassword'] as String,
  );
}

Map<String, dynamic> _$PasswordRecoveryDTOToJson(
        PasswordRecoveryDTO instance) =>
    <String, dynamic>{
      'emailAddress': instance.emailAddress,
      'recoveryCode': instance.recoveryCode,
      'newPassword': instance.newPassword,
    };
