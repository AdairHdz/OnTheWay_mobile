import 'package:json_annotation/json_annotation.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/evidenceDTO.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/userOverviewDTO/userOverviewDTO.dart';

part "reviewDTO.g.dart";

@JsonSerializable(explicitToJson: true)
class ReviewDTO {
  String id;
  String dateOfReview;
  String title;
  String details;
  int score;
  List<EvidenceDTO> evidence;
  UserOverviewDTO serviceRequester;

  ReviewDTO(
      {this.id,
      this.dateOfReview,
      this.title,
      this.details,
      this.score,
      this.evidence,
      this.serviceRequester});

  factory ReviewDTO.fromJson(Map<String, dynamic> json) =>
      _$ReviewDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewDTOToJson(this);
}
