import "package:flutter/material.dart";
import 'package:on_the_way_mobile/screens/rates_screen.dart';
//import "../widgets/services_list.dart";

class ServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("On The Way"),
      ),
      //body: ServicesList(),
      body: Center(
        child: RaisedButton(
          child: Text("Tarifas"),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RatesScreen(),
            ));
          },
        ) 
      )
    );
  }
}
