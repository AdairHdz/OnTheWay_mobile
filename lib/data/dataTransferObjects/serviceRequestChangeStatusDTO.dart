import 'package:json_annotation/json_annotation.dart';

part "serviceRequestChangeStatusDTO.g.dart";

@JsonSerializable()
class ServiceRequestStatusDTO {
  int serviceStatus;
  ServiceRequestStatusDTO(this.serviceStatus);

  factory ServiceRequestStatusDTO.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestStatusDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceRequestStatusDTOToJson(this);
}
