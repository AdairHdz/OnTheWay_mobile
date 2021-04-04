import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'newSpecialRate_screen.dart';
import 'newRate_screen.dart';
//import 'package:on_the_way_mobile/screens/';

class RatesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("On The Way"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            //margin: const EdgeInsets.only(left: 20, right: 20, top: 260),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tarifas',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RaisedButton(
                        color: Colors.lightBlue,
                        textColor: Colors.white,
                        child: Text("Nueva tarifa"),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NewRateScreen(),
                          ));
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RaisedButton(
                        color: Colors.lightBlue,
                        textColor: Colors.white,
                        child: Text("Nueva tarifa especial"),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NewSpecialRateScreen(),
                          ));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                                
              ],
            ),
          )
        ],
      ),
    );
  }
}
