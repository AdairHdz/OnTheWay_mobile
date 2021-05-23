import 'package:json_annotation/json_annotation.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/cityDTO/cityDTO.dart';

part "priceRateDTO.g.dart";

@JsonSerializable()
class PriceRateDTO {
  String id;
  String startingHour;
  String endingHour;
  double price;
  int kindOfService;
  CityDTO city;
  List<int> workingDays;

  PriceRateDTO(
      {this.id,
      this.startingHour,
      this.endingHour,
      this.price,
      this.kindOfService,
      this.city,
      this.workingDays});

  factory PriceRateDTO.fromJson(Map<String, dynamic> json) =>
      _$PriceRateDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PriceRateDTOToJson(this);
}
