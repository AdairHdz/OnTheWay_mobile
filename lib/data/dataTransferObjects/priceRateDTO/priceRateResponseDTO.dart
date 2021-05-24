import 'package:json_annotation/json_annotation.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/cityDTO/cityDTO.dart';

part 'priceRateResponseDTO.g.dart';

@JsonSerializable()
class PriceRateResponseDTO {
  String id;
  String startingHour;
  String endingHour;
  double price;
  int kindOfService;
  CityDTO city;
  List<int> workingDays;

  PriceRateResponseDTO(
      {this.id,
      this.startingHour,
      this.endingHour,
      this.price,
      this.kindOfService,
      this.city,
      this.workingDays});

  factory PriceRateResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$PriceRateResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PriceRateResponseDTOToJson(this);
}
