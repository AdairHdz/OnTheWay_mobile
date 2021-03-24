import 'package:flutter/material.dart';
import "../models/Service.dart";
import "./service_item.dart";

class ServicesList extends StatelessWidget {
  final List<Service> services = [
    Service(
      accepted: true,
      cost: 80.00,
      date: DateTime.now(),
      deliveryAddress: "Pedro Moreno #21",
      description: "2 cajas de Ibuprofeno",
      kindOfService: KindOfService.Delivery,
      serviceStatus: ServiceStatus.Active,
    ),
    Service(
      accepted: true,
      cost: 80.00,
      date: DateTime.now(),
      deliveryAddress: "Pedro Moreno #21",
      description: "2 cajas de Ibuprofeno",
      kindOfService: KindOfService.DrugsPurchase,
      serviceStatus: ServiceStatus.Canceled,
    ),
    Service(
      accepted: true,
      cost: 80.00,
      date: DateTime.now(),
      deliveryAddress: "Pedro Moreno #21",
      description: "2 cajas de Ibuprofeno",
      kindOfService: KindOfService.DrugsPurchase,
      serviceStatus: ServiceStatus.Concretized,
    ),
    Service(
      accepted: true,
      cost: 80.00,
      date: DateTime.now(),
      deliveryAddress: "Pedro Moreno #21",
      description: "2 cajas de Ibuprofeno",
      kindOfService: KindOfService.GroceriesPurchase,
      serviceStatus: ServiceStatus.Concretized,
    ),
    Service(
      accepted: true,
      cost: 80.00,
      date: DateTime.now(),
      deliveryAddress: "Pedro Moreno #21",
      description: "2 cajas de Ibuprofeno",
      kindOfService: KindOfService.GroceriesPurchase,
      serviceStatus: ServiceStatus.Concretized,
    ),
    Service(
      accepted: true,
      cost: 80.00,
      date: DateTime.now(),
      deliveryAddress: "Pedro Moreno #21",
      description: "2 cajas de Ibuprofeno",
      kindOfService: KindOfService.Delivery,
      serviceStatus: ServiceStatus.Concretized,
    ),
    Service(
      accepted: true,
      cost: 80.00,
      date: DateTime.now(),
      deliveryAddress: "Pedro Moreno #21",
      description: "2 cajas de Ibuprofeno",
      kindOfService: KindOfService.Delivery,
      serviceStatus: ServiceStatus.Concretized,
    ),
    Service(
      accepted: true,
      cost: 80.00,
      date: DateTime.now(),
      deliveryAddress: "Pedro Moreno #21",
      description: "2 cajas de Ibuprofeno",
      kindOfService: KindOfService.Otro,
      serviceStatus: ServiceStatus.Concretized,
    ),
    Service(
      accepted: true,
      cost: 80.00,
      date: DateTime.now(),
      deliveryAddress: "Pedro Moreno #21",
      description: "2 cajas de Ibuprofeno",
      kindOfService: KindOfService.Otro,
      serviceStatus: ServiceStatus.Canceled,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            child: SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (buildContext, index) {
                  return ServiceItem(services[index]);
                },
              ),
            ),
          )),
    );
  }
}
