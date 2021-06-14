import 'package:json_annotation/json_annotation.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/requestedServicesPerKindOfServiceDTO.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/requestedServicesPerWeekdayDTO.dart';

part "statisticsDTO.g.dart";

@JsonSerializable(explicitToJson: true)
class StatisticsDTO {
  List<RequestedServicesPerWeekdayDTO> requestedServicesPerWeekday;
  List<RequestedServicesPerKindOfServiceDTO> requestedServicesPerKindOfService;

  StatisticsDTO(
      this.requestedServicesPerWeekday, this.requestedServicesPerKindOfService);

  factory StatisticsDTO.fromJson(Map<String, dynamic> json) =>
      _$StatisticsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticsDTOToJson(this);
}
