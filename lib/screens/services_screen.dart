import 'dart:async';
import 'dart:convert';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/serviceRequestDTO/serviceRequestDTO.dart';
import 'package:on_the_way_mobile/data/restRequest/restRequest.dart';
import 'package:on_the_way_mobile/helpers/customExceptions/networkRequestException.dart';
import 'package:on_the_way_mobile/helpers/notifier.dart';
import 'package:on_the_way_mobile/helpers/sessionManager/Session.dart';
import 'package:on_the_way_mobile/widgets/accent_button.dart';
import 'package:on_the_way_mobile/widgets/services_list.dart';

class ServicesScreen extends StatefulWidget {
  static final String routeName = "/services";
  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  List<ServiceRequestDTO> serviceRequestDTOList = List.empty(growable: true);
  Future<void> _getServiceRequests() async {
    RestRequest request = RestRequest();
    try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(_startingDate);
      Map<String, String> queryParams = {"date": formattedDate};
      var response = await request.getResource(
          "/v1.0.0/providers/${Session().id}/requests",
          true,
          null,
          queryParams);
      setState(() {
        serviceRequestDTOList = (json.decode(response.body) as List)
            .map((i) => ServiceRequestDTO.fromJson(i))
            .toList();
      });
    } on TimeoutException catch (_) {
      showNotification(
          context,
          "Se ha agotado el tiempo de espera",
          "El servidor ha tardado demasiado en responder. Por favor, intente más tarde",
          "Aceptar");
    } on NetworkRequestException catch (error) {
      String exceptionMessage;
      switch (error.httpCode) {
        case 400:
          exceptionMessage =
              "Por favor asegúrese de haber introducido información válida e intente nuevamente.";
          break;
        case 401:
          exceptionMessage = "Lo sentimos; su sesión ha expirado.";
          break;
        case 404:
          setState(() {
            serviceRequestDTOList = List.empty(growable: true);
          });
          exceptionMessage =
              "No se encontraron solicitudes de servicio para la fecha indicada.";
          break;
        case 409:
          exceptionMessage =
              "Lo sentimos; ha ocurrido un error al intentar procesar su solicitud.";
          break;
        default:
          exceptionMessage =
              "Ha ocurrido un error desconocido. Por favor, intente m{as tarde.}.";
          break;
      }
      showNotification(context, "Error", exceptionMessage, "Aceptar");
    }
  }

  @override
  void initState() {
    super.initState();
    _getServiceRequests();
  }

  DateTime _startingDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Servicios"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [
                    Text("Fecha",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    SizedBox(height: 20),
                    GestureDetector(
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.utc(2021, 1, 1),
                                  lastDate: DateTime.now())
                              .then((value) {
                            setState(() {
                              if (value != null) {
                                _startingDate = value;
                              }
                            });
                          });
                        },
                        child: Text(DateFormat.yMMMEd().format(_startingDate))),
                    AccentButton(_getServiceRequests, "Buscar"),
                  ]),
                ],
              ),
            ),
            ServicesList(serviceRequests: serviceRequestDTOList)
          ],
        ),
      ),
    );
  }
}
