import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:on_the_way_mobile/widgets/accent_button.dart';
import 'package:on_the_way_mobile/widgets/simple_line_chart.dart';

class StatisticsScreen extends StatefulWidget {
  DateTime _startingDate = DateTime.now();
  DateTime _endingDate = DateTime.now();
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Estadísticas"),
      ),
      body: Column(
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
                                    widget._startingDate = value;
                                  });
                                });
                              },
                              child: Text(DateFormat.yMMMEd()
                                  .format(widget._startingDate))),
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
                                    widget._endingDate = value;
                                  });
                                });
                              },
                              child: Text(DateFormat.yMMMEd()
                                  .format(widget._endingDate))),
                        ])
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    SizedBox(height: 30),
                    AccentButton(() => print(widget._startingDate), "Aceptar"),
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
                    child: SimpleLineChart.withSampleData(),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
