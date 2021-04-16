import "package:flutter/foundation.dart";

enum KindOfService {
  GroceriesPurchase,
  DrugsPurchase,
  Delivery,
  Otro,
}

enum ServiceStatus {
  Concretized,
  Canceled,
  Active,
}

class Service {
  final bool accepted;
  final double cost;
  final DateTime date;
  final String deliveryAddress;
  final String description;
  final KindOfService kindOfService;
  final ServiceStatus serviceStatus;

  Service({
    @required this.accepted,
    @required this.cost,
    @required this.date,
    @required this.deliveryAddress,
    @required this.description,
    @required this.kindOfService,
    @required this.serviceStatus,
  });
}
