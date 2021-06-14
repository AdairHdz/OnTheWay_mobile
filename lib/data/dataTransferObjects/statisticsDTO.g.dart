// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statisticsDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticsDTO _$StatisticsDTOFromJson(Map<String, dynamic> json) {
  return StatisticsDTO(
    (json['requestedServicesPerWeekday'] as List)
        ?.map((e) => e == null
            ? null
            : RequestedServicesPerWeekdayDTO.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
    (json['requestedServicesPerKindOfService'] as List)
        ?.map((e) => e == null
            ? null
            : RequestedServicesPerKindOfServiceDTO.fromJson(
                e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$StatisticsDTOToJson(StatisticsDTO instance) =>
    <String, dynamic>{
      'requestedServicesPerWeekday': instance.requestedServicesPerWeekday
          ?.map((e) => e?.toJson())
          ?.toList(),
      'requestedServicesPerKindOfService': instance
          .requestedServicesPerKindOfService
          ?.map((e) => e?.toJson())
          ?.toList(),
    };
