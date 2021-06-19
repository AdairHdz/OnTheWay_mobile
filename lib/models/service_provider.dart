import "package:flutter/foundation.dart";

class ServiceProvider{
  final String name;
  final String lastName;
  final double rate;

  ServiceProvider({
    @required this.name,
    @required this.lastName,
    @required this.rate,
  });
}