import "package:flutter/foundation.dart";

class Rate{
  final String typeService;
  final String city;
  final String sector;
  final double rate;

  Rate({
    @required this.typeService,
    @required this.city,
    @required this.sector,
    @required this.rate,
  });
}