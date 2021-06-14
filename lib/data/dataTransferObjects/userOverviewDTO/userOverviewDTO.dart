import 'package:json_annotation/json_annotation.dart';

part "userOverviewDTO.g.dart";

@JsonSerializable()
class UserOverviewDTO {
  String id;
  String names;
  String lastName;

  UserOverviewDTO(this.id, this.names, this.lastName);

  factory UserOverviewDTO.fromJson(Map<String, dynamic> json) =>
      _$UserOverviewDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserOverviewDTOToJson(this);
}
