// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviewDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewDTO _$ReviewDTOFromJson(Map<String, dynamic> json) {
  return ReviewDTO(
    id: json['id'] as String,
    dateOfReview: json['dateOfReview'] as String,
    title: json['title'] as String,
    details: json['details'] as String,
    score: json['score'] as int,
    evidence: (json['evidence'] as List)
        ?.map((e) =>
            e == null ? null : EvidenceDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    serviceRequester: json['serviceRequester'] == null
        ? null
        : UserOverviewDTO.fromJson(
            json['serviceRequester'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReviewDTOToJson(ReviewDTO instance) => <String, dynamic>{
      'id': instance.id,
      'dateOfReview': instance.dateOfReview,
      'title': instance.title,
      'details': instance.details,
      'score': instance.score,
      'evidence': instance.evidence?.map((e) => e?.toJson())?.toList(),
      'serviceRequester': instance.serviceRequester?.toJson(),
    };
