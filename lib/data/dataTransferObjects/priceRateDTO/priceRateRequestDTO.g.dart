// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'priceRateRequestDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceRateRequestDTO _$PriceRateRequestDTOFromJson(Map<String, dynamic> json) {
  return PriceRateRequestDTO(
    startingHour: json['startingHour'] as String,
    endingHour: json['endingHour'] as String,
    price: (json['price'] as num)?.toDouble(),
    kindOfService: json['kindOfService'] as int,
    cityId: json['cityId'] as String,
    workingDays: (json['workingDays'] as List)?.map((e) => e as int)?.toList(),
  )..id = json['id'] as String;
}

Map<String, dynamic> _$PriceRateRequestDTOToJson(
        PriceRateRequestDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startingHour': instance.startingHour,
      'endingHour': instance.endingHour,
      'price': instance.price,
      'kindOfService': instance.kindOfService,
      'cityId': instance.cityId,
      'workingDays': instance.workingDays,
    };
