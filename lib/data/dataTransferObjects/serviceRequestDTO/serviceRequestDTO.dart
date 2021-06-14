import 'package:json_annotation/json_annotation.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/addressDTO.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/userOverviewDTO/userOverviewDTO.dart';

part "serviceRequestDTO.g.dart";

@JsonSerializable(explicitToJson: true)
class ServiceRequestDTO {
  String id;
  String date;
  int status;
  double cost;
  AddressDTO deliveryAddress;
  String description;
  int kindOfService;
  UserOverviewDTO serviceProvider;
  UserOverviewDTO serviceRequester;

  ServiceRequestDTO(
      this.id,
      this.date,
      this.status,
      this.cost,
      this.deliveryAddress,
      this.description,
      this.kindOfService,
      this.serviceProvider,
      this.serviceRequester);

  factory ServiceRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceRequestDTOToJson(this);
}
