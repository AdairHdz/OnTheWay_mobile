import 'dart:html';
import "package:flutter/material.dart";
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import "package:flutter/material.dart";
import "package:flutter/material.dart";
import "../models/service_provider.dart";
import "../widgets/service_provider_item.dart";

class ServiceProviderListScreen extends StatefulWidget {
  static final String routeName = "/service-providers-list";

  @override
  _ServiceProviderListState createState() => _ServiceProviderListState();
}

class _ServiceProviderListState extends State<ServiceProviderListScreen> {
  final List<ServiceProvider> serviceProviders = [
    ServiceProvider(
      name: "Hiram",
      lastName: "Adonai Serrano",
      rate: 4.5,
    ),
    ServiceProvider(
      name: "El Ferras",
      lastName: "Gomez",
      rate: 5,
    ),
    ServiceProvider(
      name: "Maria",
      lastName: "Flores",
      rate: 4.5,
    ),
    ServiceProvider(
      name: "Carlos",
      lastName: "Pérez",
      rate: 2,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "Proveedores",
              style: Theme.of(context).textTheme.headline1,
            ),
            Card(
              elevation: 10,
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    child: SizedBox(
                      height: 500,
                      child: ListView.builder(
                        itemCount: serviceProviders.length,
                        itemBuilder: (buildContext, index) {
                          return ServiceProviderItem(serviceProviders[index]);
                        },
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
