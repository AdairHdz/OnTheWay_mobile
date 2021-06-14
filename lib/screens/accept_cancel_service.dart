import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/serviceRequestChangeStatusDTO.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/serviceRequestDTO/serviceRequestDTO.dart';
import 'package:on_the_way_mobile/data/restRequest/restRequest.dart';
import 'package:on_the_way_mobile/helpers/customExceptions/networkRequestException.dart';
import 'package:on_the_way_mobile/helpers/notifier.dart';
import 'package:on_the_way_mobile/models/service.dart';
import 'package:on_the_way_mobile/widgets/accent_button.dart';

class AcceptCancelService extends StatelessWidget {
  static final String routeName = "/accept_cancel_service";

  Widget build(BuildContext context) {
    bool isVisibleForCancel = true;
    bool isVisibleForAccept = true;
    final ServiceRequestDTO service = ModalRoute.of(context).settings.arguments;

    Future<void> _changeServiceStatus(int serviceStatus) async {
      RestRequest request = RestRequest();
      try {
        ServiceRequestStatusDTO serviceRequestStatusDTO =
            ServiceRequestStatusDTO(serviceStatus);
        var response = await request.patchResource(
            "/v1/requests/${service.id}", serviceRequestStatusDTO, true);
        if (response.statusCode == 200) {
          String title;
          String message;
          if (ServiceStatus.values[serviceStatus] == ServiceStatus.Active) {
            title = "Servicio aceptado";
            message = "Ha aceptado la solicitud de servicio.";
          } else {
            title = "Servicio rechazado";
            message = "Ha rechazado la solicitud de servicio.";
          }
          showNotification(context, title, message, "Aceptar");
        }
      } on TimeoutException catch (_) {
        showNotification(
            context,
            "Se ha agotado el tiempo de espera",
            "El servidor ha tardado demasiado en responder. Por favor, intente más tarde",
            "Aceptar");
      } on NetworkRequestException catch (error) {
        showNotification(
            context, "Ha ocurrido un error de red", error.cause, "Aceptar");
      }
    }

    String _getAddress() {
      String addressOverview =
          "${service.deliveryAddress.street} #${service.deliveryAddress.outdoorNumber}";
      if (service.deliveryAddress.indoorNumber != null &&
          service.deliveryAddress.indoorNumber != "") {
        addressOverview += ", Interior ${service.deliveryAddress.indoorNumber}";
      }
      addressOverview +=
          ", col. ${service.deliveryAddress.suburb}; ${service.deliveryAddress.city.name}";
      return addressOverview;
    }

    String _kindOfService() {
      KindOfService kindOfService = KindOfService.values[service.kindOfService];
      String kindOfServiceText;
      switch (kindOfService) {
        case KindOfService.ServicePayment:
          kindOfServiceText = "Pago de servicios";
          break;
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

    switch (ServiceStatus.values[service.status]) {
      case ServiceStatus.Active:
        isVisibleForAccept = false;
        break;
      case ServiceStatus.Concretized:
        isVisibleForAccept = false;
        isVisibleForCancel = false;
        break;
      case ServiceStatus.Canceled:
        isVisibleForAccept = false;
        isVisibleForCancel = false;
        break;
      case ServiceStatus.Pending:
        isVisibleForAccept = true;
        isVisibleForCancel = true;
        break;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Detalles del servicio"),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ]),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(
                        left: 10, top: 20, right: 10, bottom: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Detalles del servicio",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                Container(
                  margin:
                      EdgeInsets.only(left: 30, top: 20, right: 10, bottom: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _kindOfService(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 30, top: 0, right: 30, bottom: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Solicitante: ${service.serviceRequester.names} ${service.serviceRequester.lastName}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 30, top: 0, right: 30, bottom: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Descripción:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(left: 30, top: 0, right: 30, bottom: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding:
                      EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 180),
                  child: Text(
                    service.description,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 30, top: 20, right: 30, bottom: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Dirección de entrega: " + _getAddress(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 30, top: 20, right: 30, bottom: 20),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Tarifa: " + service.cost.toString() + " MXN",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 20),
                  padding:
                      EdgeInsets.only(left: 50, top: 20, right: 50, bottom: 20),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Visibility(
                          visible: isVisibleForAccept,
                          child: AccentButton(() {
                            _changeServiceStatus(1);
                          }, "Aceptar")),
                      Visibility(
                          visible: isVisibleForCancel,
                          child: AccentButton(() {
                            _changeServiceStatus(3);
                          }, "Cancelar"))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
