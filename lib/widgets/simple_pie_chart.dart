import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/requestedServicesPerKindOfServiceDTO.dart';

// ignore: must_be_immutable
class SimplePieChart extends StatelessWidget {
  List<RequestedServicesPerKindOfServiceDTO>
      requestedServicesPerKindOfServiceDTO;

  SimplePieChart({Key key, this.requestedServicesPerKindOfServiceDTO})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildChart(context),
    );
  }

  List<charts.Series<ServiceRequestPerKindOfService, String>> _seriesPieData =
      new List<charts.Series<ServiceRequestPerKindOfService, String>>.empty(
          growable: true);
  List<ServiceRequestPerKindOfService> myData;
  _generateData(myData) {
    _seriesPieData.add(charts.Series(
        domainFn: (ServiceRequestPerKindOfService serviceRequest, _) =>
            serviceRequest.kindOfServiceName,
        measureFn: (ServiceRequestPerKindOfService serviceRequest, _) =>
            serviceRequest.serviceRequests,
        colorFn: (ServiceRequestPerKindOfService serviceRequest, _) =>
            charts.ColorUtil.fromDartColor(
                Color(int.parse(serviceRequest.color))),
        id: "Service requests",
        data: myData));
  }

  String getKindOfServiceName(int kindOfService) {
    String kindOfServiceName;
    switch (kindOfService) {
      case 0:
        kindOfServiceName = "Pago de servicios";
        break;
      case 1:
        kindOfServiceName = "Compra de fármacos";
        break;
      case 2:
        kindOfServiceName = "Compra de víveres";
        break;
      case 3:
        kindOfServiceName = "Entrega";
        break;
      case 4:
        kindOfServiceName = "Otro";
        break;
      default:
        kindOfServiceName = "Error";
        break;
    }
    return kindOfServiceName;
  }

  String getDataColor(int kindOfService) {
    String dataColor;
    switch (kindOfService) {
      case 0:
        dataColor = "0xFFFA6464";
        break;
      case 1:
        dataColor = "0xFF521BFA";
        break;
      case 2:
        dataColor = "0xFF646464";
        break;
      case 3:
        dataColor = "0xFF56E678";
        break;
      case 4:
        dataColor = "0xFF5C7DFA";
        break;
      default:
        dataColor = "0xFFFA6464";
        break;
    }
    return dataColor;
  }

  Widget _buildChart(BuildContext context) {
    myData = new List<ServiceRequestPerKindOfService>.empty(growable: true);

    List<int> kindOfService = List<int>.generate(5, (index) => index);
    requestedServicesPerKindOfServiceDTO.forEach((requestedService) {
      kindOfService.remove(requestedService.kindOfService);
      myData.add(new ServiceRequestPerKindOfService(
          requestedService.kindOfService,
          requestedService.requestedServices,
          getKindOfServiceName(requestedService.kindOfService),
          getDataColor(requestedService.kindOfService)));
    });

    _generateData(myData);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: Center(
          child: Column(
            children: [
              Text(
                "Tipos de servicio ofrecidos",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: charts.PieChart(
                _seriesPieData,
                animate: true,
                animationDuration: Duration(seconds: 1),
                behaviors: [
                  charts.DatumLegend(
                    outsideJustification:
                        charts.OutsideJustification.endDrawArea,
                    horizontalFirst: false,
                    desiredMaxRows: 3,
                    cellPadding: EdgeInsets.only(right: 4, bottom: 4, top: 4),
                    entryTextStyle: charts.TextStyleSpec(
                        fontFamily: "Georgia", fontSize: 10),
                  ),
                ],
                defaultRenderer: new charts.ArcRendererConfig(
                  arcWidth: 100,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceRequestPerKindOfService {
  final int kindOfService;
  final int serviceRequests;
  final String kindOfServiceName;
  final String color;
  ServiceRequestPerKindOfService(this.kindOfService, this.serviceRequests,
      this.kindOfServiceName, this.color);
}
