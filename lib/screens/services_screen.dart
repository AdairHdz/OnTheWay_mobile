import "package:flutter/material.dart";
import "../widgets/services_list.dart";

class ServicesScreen extends StatelessWidget {
  static final String routeName = "/services";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Servicios"),
      ),
      body: ServicesList(),
    );
  }
}
