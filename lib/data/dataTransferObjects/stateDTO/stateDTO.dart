import 'package:json_annotation/json_annotation.dart';

part "stateDTO.g.dart";

@JsonSerializable()
class StateDTO {
  String id;
  String name;

  StateDTO(this.id, this.name);

  factory StateDTO.fromJson(Map<String, dynamic> json) =>
      _$StateDTOFromJson(json);

  Map<String, dynamic> toJson() => _$StateDTOToJson(this);
}
