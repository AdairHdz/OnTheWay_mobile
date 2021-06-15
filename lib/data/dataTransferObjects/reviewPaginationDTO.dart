import 'package:json_annotation/json_annotation.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/linksDTO.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/reviewDTO.dart';

part "reviewPaginationDTO.g.dart";

@JsonSerializable(explicitToJson: true)
class ReviewPaginationDTO {
  LinksDTO links;
  int page;
  int pages;
  int perPage;
  int total;
  List<ReviewDTO> data;

  ReviewPaginationDTO(
      {this.links, this.page, this.pages, this.perPage, this.total});

  factory ReviewPaginationDTO.fromJson(Map<String, dynamic> json) =>
      _$ReviewPaginationDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewPaginationDTOToJson(this);
}
