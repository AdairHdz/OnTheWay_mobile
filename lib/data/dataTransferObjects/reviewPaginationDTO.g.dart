// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviewPaginationDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewPaginationDTO _$ReviewPaginationDTOFromJson(Map<String, dynamic> json) {
  return ReviewPaginationDTO(
    links: json['links'] == null
        ? null
        : LinksDTO.fromJson(json['links'] as Map<String, dynamic>),
    page: json['page'] as int,
    pages: json['pages'] as int,
    perPage: json['perPage'] as int,
    total: json['total'] as int,
  )..data = (json['data'] as List)
      ?.map((e) =>
          e == null ? null : ReviewDTO.fromJson(e as Map<String, dynamic>))
      ?.toList();
}

Map<String, dynamic> _$ReviewPaginationDTOToJson(
        ReviewPaginationDTO instance) =>
    <String, dynamic>{
      'links': instance.links?.toJson(),
      'page': instance.page,
      'pages': instance.pages,
      'perPage': instance.perPage,
      'total': instance.total,
      'data': instance.data?.map((e) => e?.toJson())?.toList(),
    };
