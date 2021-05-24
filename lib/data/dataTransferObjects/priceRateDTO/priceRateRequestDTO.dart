import 'package:json_annotation/json_annotation.dart';

part 'priceRateRequestDTO.g.dart';

@JsonSerializable()
class PriceRateRequestDTO {
  String id;
  String startingHour;
  String endingHour;
  double price;
  int kindOfService;
  String cityId;
  List<int> workingDays;

  PriceRateRequestDTO(
      {this.startingHour,
      this.endingHour,
      this.price,
      this.kindOfService,
      this.cityId,
      this.workingDays});

  factory PriceRateRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$PriceRateRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PriceRateRequestDTOToJson(this);
}
