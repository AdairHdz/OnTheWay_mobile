import 'package:json_annotation/json_annotation.dart';

part "requestedServicesPerKindOfServiceDTO.g.dart";

@JsonSerializable()
class RequestedServicesPerKindOfServiceDTO {
  int requestedServices;
  int kindOfService;

  RequestedServicesPerKindOfServiceDTO(
      this.requestedServices, this.kindOfService);

  factory RequestedServicesPerKindOfServiceDTO.fromJson(
          Map<String, dynamic> json) =>
      _$RequestedServicesPerKindOfServiceDTOFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RequestedServicesPerKindOfServiceDTOToJson(this);
}
