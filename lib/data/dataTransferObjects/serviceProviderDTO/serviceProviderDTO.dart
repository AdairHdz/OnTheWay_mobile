import 'package:json_annotation/json_annotation.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/priceRateDTO/priceRateResponseDTO.dart';

part "serviceProviderDTO.g.dart";

@JsonSerializable(explicitToJson: true)
class ServiceProviderDTO {
  String id;
  String names;
  String lastName;
  String emailAddress;
  int averageScore;
  List<PriceRateResponseDTO> priceRates;

  ServiceProviderDTO(
      {this.id,
      this.names,
      this.lastName,
      this.emailAddress,
      this.averageScore,
      this.priceRates});

  factory ServiceProviderDTO.fromJson(Map<String, dynamic> json) =>
      _$ServiceProviderDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceProviderDTOToJson(this);
}
