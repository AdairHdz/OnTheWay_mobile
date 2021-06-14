// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userOverviewDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserOverviewDTO _$UserOverviewDTOFromJson(Map<String, dynamic> json) {
  return UserOverviewDTO(
    json['id'] as String,
    json['names'] as String,
    json['lastName'] as String,
  );
}

Map<String, dynamic> _$UserOverviewDTOToJson(UserOverviewDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'names': instance.names,
      'lastName': instance.lastName,
    };
