import "package:flutter/material.dart";
import 'package:on_the_way_mobile/widgets/custom_dropdown_button.dart';
import '../widgets/price_rate.dart';
import "../widgets/profile_info.dart";

class HomeScreen extends StatelessWidget {
  static final String routeName = "/home";

  void navigateToPriceRateRegistry(BuildContext context) {
    Navigator.of(context).pushNamed("/price-rate");
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("List of services"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          foregroundColor: Colors.white,
          onPressed: () => navigateToPriceRateRegistry(context),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProfileInfo(),
              Container(
                width: deviceWidth * 0.95,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        width: deviceWidth,
                        child: Text("Tarifas",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          width: deviceWidth,
                          child: CustomDropdownButton(
                              hint: "Ciudad",
                              options: ["Xalapa", "Coatepec", "Veracruz"])),
                      PriceRate()
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
