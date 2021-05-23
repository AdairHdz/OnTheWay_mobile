import 'package:json_annotation/json_annotation.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/priceRateDTO/priceRateDTO.dart';

part "serviceProviderDTO.g.dart";

@JsonSerializable(explicitToJson: true)
class ServiceProviderDTO {
  String id;
  String names;
  String lastName;
  String emailAddress;
  int averageScore;
  List<PriceRateDTO> priceRates;

  ServiceProviderDTO(
      {this.id,
      this.names,
      this.lastName,
      this.emailAddress,
      this.averageScore,
      this.priceRates});

  factory ServiceProviderDTO.fromJson(Map<String, dynamic> json) =>
      _$ServiceProviderDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceProviderDTOToJson(this);

  /*
  [
  {
    "id": "1a9f2c27-f0e2-48e5-bf9c-a5905f7cd199",
    "names": "Christian",
    "lastName": "Graves",
    "emailAddress": "christian@gmail.com",
    "averageScore": 1,
    "priceRates": [
      {
        "id": "2b0f45e3-cdfc-419d-b092-286a9e641f5b",
        "startingHour": "00:34:19 GMT+0000 (UTC)",
        "endingHour": "17:05:37 GMT+0000 (UTC)",
        "price": 56,
        "kindOfService": 1,
        "city": {
          "id": "b4460fb9-5c0a-4c70-a08c-389145c00ca2",
          "name": "Riverton"
        },
        "workingDays": [
          1,
          2
        ]
      },
      {
        "id": "772a683b-fa89-4797-868f-4a675f35308f",
        "startingHour": "Tue Feb 24 1976 16:26:42 GMT+0000 (UTC)",
        "endingHour": "Thu Dec 19 1974 12:06:19 GMT+0000 (UTC)",
        "price": "43",
        "kindOfService": 3,
        "city": {
          "id": "35c49a58-519b-4d06-a763-dd51278593b3",
          "name": "Roeville"
        },
        "workingDays": [
          3,
          5
        ]
      }
    ]
  }
]
  */

}
