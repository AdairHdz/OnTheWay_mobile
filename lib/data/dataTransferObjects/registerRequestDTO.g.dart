// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registerRequestDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestDTO _$RegisterRequestDTOFromJson(Map<String, dynamic> json) {
  return RegisterRequestDTO(
    names: json['names'] as String,
    lastName: json['lastName'] as String,
    emailAddress: json['emailAddress'] as String,
    userType: json['userType'] as int,
    password: json['password'] as String,
    stateId: json['stateId'] as String,
  );
}

Map<String, dynamic> _$RegisterRequestDTOToJson(RegisterRequestDTO instance) =>
    <String, dynamic>{
      'names': instance.names,
      'lastName': instance.lastName,
      'emailAddress': instance.emailAddress,
      'userType': instance.userType,
      'password': instance.password,
      'stateId': instance.stateId,
    };
