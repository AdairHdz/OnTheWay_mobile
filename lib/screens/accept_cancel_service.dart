import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/service.dart';

class AcceptCancelService extends StatelessWidget {
  static final String routeName = "/accept_cancel_service";
  bool isVisibleForCancel = true;
  bool isVisibleForAccept = true;
  @override
  Widget build(BuildContext context) {
    final Map service = ModalRoute.of(context).settings.arguments;
    switch (service['serviceStatus']) {
      case 'Activo':
        isVisibleForAccept = false;
        break;
      case 'Concretado':
        isVisibleForAccept = false;
        isVisibleForCancel = false;
        break;
      case 'Cancelado':
        isVisibleForAccept = false;
        isVisibleForCancel = false;
        break;
      case 'Pendiente':
        isVisibleForAccept = true;
        isVisibleForCancel = true;
        break;
      case 'Indefinido':
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
                    margin: EdgeInsets.all(20),
                    child: Text(
                      "Solicitud de servicio",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                  margin:
                      EdgeInsets.only(left: 30, top: 20, right: 10, bottom: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      service['kindOfService'],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
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
                      "Solicitante: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
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
                          fontSize: 22),
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
                    service['description'],
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
                      "Dirección de entrega: " + service['deliveryAddress'],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 22),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 30, top: 20, right: 30, bottom: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Tarifa: " + service['cost'].toString() + " MXN",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 22),
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 50, top: 20, right: 50, bottom: 20),
                  padding:
                      EdgeInsets.only(left: 50, top: 20, right: 50, bottom: 20),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Visibility(
                          visible: isVisibleForAccept,
                          child: ElevatedButton(
                            onPressed: () {
                              service['serviceStatus'] = 'Activo';
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                                onPrimary: Colors.black),
                            child: Text("Aceptar",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                          ),
                        ),
                        Visibility(
                          visible: isVisibleForCancel,
                          child: ElevatedButton(
                            onPressed: () {
                              service['serviceStatus'] = 'Cancelado';
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                                onPrimary: Colors.black),
                            child: Text("Cancelar",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
