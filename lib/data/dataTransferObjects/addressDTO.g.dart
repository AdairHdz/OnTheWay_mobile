// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addressDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressDTO _$AddressDTOFromJson(Map<String, dynamic> json) {
  return AddressDTO(
    json['id'] as String,
    json['indoorNumber'] as String,
    json['outdoorNumber'] as String,
    json['street'] as String,
    json['suburb'] as String,
    json['city'] == null
        ? null
        : CityDTO.fromJson(json['city'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AddressDTOToJson(AddressDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'indoorNumber': instance.indoorNumber,
      'outdoorNumber': instance.outdoorNumber,
      'street': instance.street,
      'suburb': instance.suburb,
      'city': instance.city?.toJson(),
    };
