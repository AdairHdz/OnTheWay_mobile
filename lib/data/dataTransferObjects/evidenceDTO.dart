import 'package:json_annotation/json_annotation.dart';

part "evidenceDTO.g.dart";

@JsonSerializable()
class EvidenceDTO {
  String link;
  String name;

  EvidenceDTO({this.link, this.name});

  factory EvidenceDTO.fromJson(Map<String, dynamic> json) =>
      _$EvidenceDTOFromJson(json);

  Map<String, dynamic> toJson() => _$EvidenceDTOToJson(this);
}
