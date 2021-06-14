import 'package:json_annotation/json_annotation.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/cityDTO/cityDTO.dart';

part 'addressDTO.g.dart';

@JsonSerializable(explicitToJson: true)
class AddressDTO {
  String id;
  String indoorNumber;
  String outdoorNumber;
  String street;
  String suburb;
  CityDTO city;

  AddressDTO(this.id, this.indoorNumber, this.outdoorNumber, this.street,
      this.suburb, this.city);

  factory AddressDTO.fromJson(Map<String, dynamic> json) =>
      _$AddressDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDTOToJson(this);
}
