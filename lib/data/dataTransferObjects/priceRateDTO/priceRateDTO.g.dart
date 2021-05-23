// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'priceRateDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceRateDTO _$PriceRateDTOFromJson(Map<String, dynamic> json) {
  return PriceRateDTO(
    id: json['id'] as String,
    startingHour: json['startingHour'] as String,
    endingHour: json['endingHour'] as String,
    price: (json['price'] as num)?.toDouble(),
    kindOfService: json['kindOfService'] as int,
    city: json['city'] == null
        ? null
        : CityDTO.fromJson(json['city'] as Map<String, dynamic>),
    workingDays: (json['workingDays'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$PriceRateDTOToJson(PriceRateDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startingHour': instance.startingHour,
      'endingHour': instance.endingHour,
      'price': instance.price,
      'kindOfService': instance.kindOfService,
      'city': instance.city,
      'workingDays': instance.workingDays,
    };
