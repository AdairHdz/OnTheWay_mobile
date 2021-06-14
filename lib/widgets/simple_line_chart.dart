import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/requestedServicesPerWeekdayDTO.dart';

// ignore: must_be_immutable
class SimpleLineChart extends StatelessWidget {
  List<RequestedServicesPerWeekdayDTO> requestedServicesPerWeekday;

  SimpleLineChart({Key key, this.requestedServicesPerWeekday})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildChart(context),
    );
  }

  List<charts.Series<ServiceRequestPerWeekday, String>> _seriesBarData =
      new List<charts.Series<ServiceRequestPerWeekday, String>>.empty(
          growable: true);
  List<ServiceRequestPerWeekday> myData;
  _generateData(myData) {
    _seriesBarData.add(charts.Series(
        domainFn: (ServiceRequestPerWeekday serviceRequest, _) =>
            serviceRequest.weekdayName,
        measureFn: (ServiceRequestPerWeekday serviceRequest, _) =>
            serviceRequest.serviceRequests,
        colorFn: (ServiceRequestPerWeekday serviceRequest, _) =>
            charts.ColorUtil.fromDartColor(Colors.orange[400]),
        id: "Servicios ofrecidos",
        data: myData,
        labelAccessorFn: (ServiceRequestPerWeekday row, _) =>
            "${row.weekdayName}"));
  }

  String getweekdayName(int weekday) {
    String day;
    switch (weekday) {
      case 0:
        day = "Lunes";
        break;
      case 1:
        day = "Martes";
        break;
      case 2:
        day = "Miércoles";
        break;
      case 3:
        day = "Jueves";
        break;
      case 4:
        day = "Viernes";
        break;
      case 5:
        day = "Sábado";
        break;
      case 6:
        day = "Domingo";
        break;
      default:
        day = "Error";
        break;
    }
    return day;
  }

  void parseServiceRequestPerWeekdayDTOToServiceRequestPerWeekdayModel() {
    myData = new List<ServiceRequestPerWeekday>.empty(growable: true);
    List<int> weekdays = new List.generate(7, (index) => index);
    weekdays.forEach((weekday) {
      var requestedServiceInWeekday =
          new ServiceRequestPerWeekday(weekday, 0, getweekdayName(weekday));

      requestedServicesPerWeekday.forEach((requestedServ) {
        if (requestedServ.weekday == weekday) {
          requestedServiceInWeekday.serviceRequests = 2;
        }
      });

      myData.add(requestedServiceInWeekday);
    });
  }

  Widget _buildChart(BuildContext context) {
    parseServiceRequestPerWeekdayDTOToServiceRequestPerWeekdayModel();
    _generateData(myData);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: Center(
          child: Column(
            children: [
              Align(
                child: Text(
                  "Servicios realizados por día de la semana",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: charts.BarChart(
                _seriesBarData,
                animate: true,
                animationDuration: Duration(seconds: 1),
                domainAxis: new charts.OrdinalAxisSpec(
                  viewport: new charts.OrdinalViewport('AePS', 3),
                ),
                behaviors: [
                  charts.DatumLegend(
                    entryTextStyle: charts.TextStyleSpec(
                        color: charts.MaterialPalette.purple.shadeDefault,
                        fontFamily: "Georgia",
                        fontSize: 8),
                  ),
                  new charts.SeriesLegend(),
                  new charts.SlidingViewport(),
                  new charts.PanAndZoomBehavior(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceRequestPerWeekday {
  int weekday;
  int serviceRequests;
  String weekdayName;
  ServiceRequestPerWeekday(
      this.weekday, this.serviceRequests, this.weekdayName);
}
