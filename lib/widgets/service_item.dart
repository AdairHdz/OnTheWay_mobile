import 'dart:developer';
import 'package:flutter/material.dart';
//import 'package:on_the_way_mobile/models/service.dart';
import '../models/Service.dart';
import 'package:intl/intl.dart';

class ServiceItem extends StatelessWidget {
  final Service service;

  ServiceItem(this.service);

  String get _kindOfService {
    KindOfService kindOfService = service.kindOfService;
    String kindOfServiceText;
    switch (kindOfService) {
      case KindOfService.Delivery:
        kindOfServiceText = "Entrega";
        break;
      case KindOfService.DrugsPurchase:
        kindOfServiceText = "Compra de fármacos";
        break;
      case KindOfService.GroceriesPurchase:
        kindOfServiceText = "Compra de víveres";
        break;
      default:
        kindOfServiceText = "Otro";
    }
    return kindOfServiceText;
  }

  String get _serviceStatus {
    ServiceStatus serviceStatus = service.serviceStatus;
    String serviceStatusText;
    switch (serviceStatus) {
      case ServiceStatus.Active:
        serviceStatusText = "Activo";
        break;
      case ServiceStatus.Concretized:
        serviceStatusText = "Concretado";
        break;
      case ServiceStatus.Canceled:
        serviceStatusText = "Cancelado";
        break;
      // case ServiceStatus.
      //   serviceStatusText = "Pendiente";
      //   break;
      default:
        serviceStatusText = "Indefinido";
    }
    return serviceStatusText;
  }

  String get _serviceImage {
    ServiceStatus serviceStatus = service.serviceStatus;
    String serviceImage;
    switch (serviceStatus) {
      case ServiceStatus.Active:
        serviceImage = "assets/images/speed.png";
        break;
      case ServiceStatus.Canceled:
        serviceImage = "assets/images/canceled.png";
        break;
      case ServiceStatus.Concretized:
        serviceImage = "assets/images/verified.png";
        break;
      default:
        serviceImage = "assets/images/pending.png";
        break;
    }
    return serviceImage;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed("/accept_cancel_service", arguments: {
          'accepted': service.accepted,
          'cost': service.cost,
          'date': service.date,
          'deliveryAddress': service.deliveryAddress,
          'description': service.description,
          'kindOfService': _kindOfService,
          'serviceStatus': _serviceStatus
        });
      },
      child: Card(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: Image(
              image: AssetImage(_serviceImage),
            ),
          ),
          title: Text(
            _kindOfService,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          subtitle: Text(
            DateFormat.yMd().add_jm().format(DateTime.now()),
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          trailing: Text(
            _serviceStatus,
            style: TextStyle(
                color: Colors.white, fontStyle: FontStyle.italic, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
