// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serviceRequestDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceRequestDTO _$ServiceRequestDTOFromJson(Map<String, dynamic> json) {
  return ServiceRequestDTO(
    json['id'] as String,
    json['date'] as String,
    json['status'] as int,
    (json['cost'] as num)?.toDouble(),
    json['deliveryAddress'] == null
        ? null
        : AddressDTO.fromJson(json['deliveryAddress'] as Map<String, dynamic>),
    json['description'] as String,
    json['kindOfService'] as int,
    json['serviceProvider'] == null
        ? null
        : UserOverviewDTO.fromJson(
            json['serviceProvider'] as Map<String, dynamic>),
    json['serviceRequester'] == null
        ? null
        : UserOverviewDTO.fromJson(
            json['serviceRequester'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ServiceRequestDTOToJson(ServiceRequestDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'status': instance.status,
      'cost': instance.cost,
      'deliveryAddress': instance.deliveryAddress?.toJson(),
      'description': instance.description,
      'kindOfService': instance.kindOfService,
      'serviceProvider': instance.serviceProvider?.toJson(),
      'serviceRequester': instance.serviceRequester?.toJson(),
    };
