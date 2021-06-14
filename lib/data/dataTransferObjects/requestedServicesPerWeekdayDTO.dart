import 'package:json_annotation/json_annotation.dart';

part "requestedServicesPerWeekdayDTO.g.dart";

@JsonSerializable()
class RequestedServicesPerWeekdayDTO {
  int requestedServices;
  int weekday;

  RequestedServicesPerWeekdayDTO(this.requestedServices, this.weekday);

  factory RequestedServicesPerWeekdayDTO.fromJson(Map<String, dynamic> json) =>
      _$RequestedServicesPerWeekdayDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RequestedServicesPerWeekdayDTOToJson(this);
}
