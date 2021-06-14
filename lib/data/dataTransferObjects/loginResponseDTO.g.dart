// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginResponseDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseDTO _$LoginResponseDTOFromJson(Map<String, dynamic> json) {
  return LoginResponseDTO(
    json['id'] as String,
    json['names'] as String,
    json['lastName'] as String,
    json['emailAddress'] as String,
    json['userType'] as int,
    json['verified'] as bool,
    json['stateId'] as String,
    json['token'] as String,
    json['userId'] as String,
  );
}

Map<String, dynamic> _$LoginResponseDTOToJson(LoginResponseDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'names': instance.names,
      'lastName': instance.lastName,
      'emailAddress': instance.emailAddress,
      'userType': instance.userType,
      'verified': instance.verified,
      'stateId': instance.stateId,
      'token': instance.token,
    };
