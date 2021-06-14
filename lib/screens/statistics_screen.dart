import 'dart:async';
import 'dart:convert';

import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/requestedServicesPerKindOfServiceDTO.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/requestedServicesPerWeekdayDTO.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/statisticsDTO.dart';
import 'package:on_the_way_mobile/data/restRequest/restRequest.dart';
import 'package:on_the_way_mobile/helpers/customExceptions/networkRequestException.dart';
import 'package:on_the_way_mobile/helpers/notifier.dart';
import 'package:on_the_way_mobile/helpers/sessionManager/Session.dart';
import 'package:on_the_way_mobile/widgets/accent_button.dart';
import 'package:on_the_way_mobile/widgets/simple_line_chart.dart';
import 'package:on_the_way_mobile/widgets/simple_pie_chart.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  DateTime _startingDate = DateTime.now();
  DateTime _endingDate = DateTime.now();
  StatisticsDTO _statisticsDTO = StatisticsDTO(
      List<RequestedServicesPerWeekdayDTO>.empty(growable: true),
      List<RequestedServicesPerKindOfServiceDTO>.empty(growable: true));
  Future<void> _getStatistics() async {
    RestRequest request = RestRequest();
    try {
      String formattedStartingdDate =
          DateFormat('yyyy-MM-dd').format(_startingDate);
      String formattedEndingdDate =
          DateFormat('yyyy-MM-dd').format(_endingDate);
      Map<String, String> queryParams = {
        "startingDate": formattedStartingdDate,
        "endingDate": formattedEndingdDate
      };
      var response = await request.getResource(
          "/v1/providers/${Session().id}/statistics", true, null, queryParams);
      Map<String, dynamic> statisticsMap = jsonDecode(response.body);
      setState(() {
        _statisticsDTO = StatisticsDTO.fromJson(statisticsMap);
      });
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

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Estadísticas"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "Estadísticas",
                style: Theme.of(context).textTheme.headline1,
              ),
              margin: EdgeInsets.symmetric(vertical: 30),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  width: (deviceWidth * .7),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(children: [
                            Text("Desde",
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
                                child: Text(
                                    DateFormat.yMMMEd().format(_startingDate))),
                          ]),
                          Column(children: [
                            Text("Hasta",
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
                                        _endingDate = value;
                                      }
                                    });
                                  });
                                },
                                child: Text(
                                    DateFormat.yMMMEd().format(_endingDate))),
                          ])
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      SizedBox(height: 30),
                      AccentButton(_getStatistics, "Aceptar"),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: deviceWidth * .85,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            "Servicios",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Completados: 25",
                          ),
                          Text(
                            "Cancelados: 4",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  width: deviceWidth * .85,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: SimpleLineChart(
                        requestedServicesPerWeekday: _statisticsDTO == null
                            ? List<RequestedServicesPerWeekdayDTO>.empty(
                                growable: true)
                            : _statisticsDTO.requestedServicesPerWeekday,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  width: deviceWidth * .85,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: SimplePieChart(
                          requestedServicesPerKindOfServiceDTO: _statisticsDTO ==
                                  null
                              ? List<RequestedServicesPerKindOfServiceDTO>.empty(
                                  growable: true)
                              : _statisticsDTO
                                  .requestedServicesPerKindOfService),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
