// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestedServicesPerWeekdayDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestedServicesPerWeekdayDTO _$RequestedServicesPerWeekdayDTOFromJson(
    Map<String, dynamic> json) {
  return RequestedServicesPerWeekdayDTO(
    json['requestedServices'] as int,
    json['weekday'] as int,
  );
}

Map<String, dynamic> _$RequestedServicesPerWeekdayDTOToJson(
        RequestedServicesPerWeekdayDTO instance) =>
    <String, dynamic>{
      'requestedServices': instance.requestedServices,
      'weekday': instance.weekday,
    };
