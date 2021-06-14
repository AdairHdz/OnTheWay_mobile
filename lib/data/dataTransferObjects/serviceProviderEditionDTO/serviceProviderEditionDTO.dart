import 'package:json_annotation/json_annotation.dart';

part "serviceProviderEditionDTO.g.dart";

@JsonSerializable()
class ServiceProviderEditionDTO {
  final String names;
  final String lastName;

  ServiceProviderEditionDTO({this.names, this.lastName});

  factory ServiceProviderEditionDTO.fromJson(Map<String, dynamic> json) =>
      _$ServiceProviderEditionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceProviderEditionDTOToJson(this);
}
