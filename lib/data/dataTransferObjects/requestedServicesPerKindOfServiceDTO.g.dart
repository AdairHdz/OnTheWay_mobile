// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestedServicesPerKindOfServiceDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestedServicesPerKindOfServiceDTO
    _$RequestedServicesPerKindOfServiceDTOFromJson(Map<String, dynamic> json) {
  return RequestedServicesPerKindOfServiceDTO(
    json['requestedServices'] as int,
    json['kindOfService'] as int,
  );
}

Map<String, dynamic> _$RequestedServicesPerKindOfServiceDTOToJson(
        RequestedServicesPerKindOfServiceDTO instance) =>
    <String, dynamic>{
      'requestedServices': instance.requestedServices,
      'kindOfService': instance.kindOfService,
    };
