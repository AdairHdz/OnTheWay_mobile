import 'package:json_annotation/json_annotation.dart';

part "cityDTO.g.dart";

@JsonSerializable()
class CityDTO {
  String id;
  String name;

  CityDTO({this.id, this.name});

  factory CityDTO.fromJson(Map<String, dynamic> json) =>
      _$CityDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CityDTOToJson(this);
}
