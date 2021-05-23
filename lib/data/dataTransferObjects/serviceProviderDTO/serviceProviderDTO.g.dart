// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serviceProviderDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceProviderDTO _$ServiceProviderDTOFromJson(Map<String, dynamic> json) {
  return ServiceProviderDTO(
    id: json['id'] as String,
    names: json['names'] as String,
    lastName: json['lastName'] as String,
    emailAddress: json['emailAddress'] as String,
    averageScore: json['averageScore'] as int,
    priceRates: (json['priceRates'] as List)
        ?.map((e) =>
            e == null ? null : PriceRateDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ServiceProviderDTOToJson(ServiceProviderDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'names': instance.names,
      'lastName': instance.lastName,
      'emailAddress': instance.emailAddress,
      'averageScore': instance.averageScore,
      'priceRates': instance.priceRates?.map((e) => e?.toJson())?.toList(),
    };
