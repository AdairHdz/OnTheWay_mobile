import 'package:json_annotation/json_annotation.dart';

part "linksDTO.g.dart";

@JsonSerializable()
class LinksDTO {
  String first;
  String last;
  String prev;
  String next;

  LinksDTO({this.first, this.last, this.prev, this.next});

  factory LinksDTO.fromJson(Map<String, dynamic> json) =>
      _$LinksDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LinksDTOToJson(this);
}
