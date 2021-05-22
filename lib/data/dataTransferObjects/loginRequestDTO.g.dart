// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginRequestDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestDTO _$LoginRequestDTOFromJson(Map<String, dynamic> json) {
  return LoginRequestDTO(
    emailAddress: json['emailAddress'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$LoginRequestDTOToJson(LoginRequestDTO instance) =>
    <String, dynamic>{
      'emailAddress': instance.emailAddress,
      'password': instance.password,
    };
