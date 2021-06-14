// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serviceRequestChangeStatusDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceRequestStatusDTO _$ServiceRequestStatusDTOFromJson(
    Map<String, dynamic> json) {
  return ServiceRequestStatusDTO(
    json['serviceStatus'] as int,
  );
}

Map<String, dynamic> _$ServiceRequestStatusDTOToJson(
        ServiceRequestStatusDTO instance) =>
    <String, dynamic>{
      'serviceStatus': instance.serviceStatus,
    };
