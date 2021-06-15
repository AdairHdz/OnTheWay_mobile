// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linksDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinksDTO _$LinksDTOFromJson(Map<String, dynamic> json) {
  return LinksDTO(
    first: json['first'] as String,
    last: json['last'] as String,
    prev: json['prev'] as String,
    next: json['next'] as String,
  );
}

Map<String, dynamic> _$LinksDTOToJson(LinksDTO instance) => <String, dynamic>{
      'first': instance.first,
      'last': instance.last,
      'prev': instance.prev,
      'next': instance.next,
    };
