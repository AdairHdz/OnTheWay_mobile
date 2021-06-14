// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serviceProviderEditionDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceProviderEditionDTO _$ServiceProviderEditionDTOFromJson(
    Map<String, dynamic> json) {
  return ServiceProviderEditionDTO(
    names: json['names'] as String,
    lastName: json['lastName'] as String,
  );
}

Map<String, dynamic> _$ServiceProviderEditionDTOToJson(
        ServiceProviderEditionDTO instance) =>
    <String, dynamic>{
      'names': instance.names,
      'lastName': instance.lastName,
    };
