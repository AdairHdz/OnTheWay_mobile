import "package:flutter/material.dart";
import "../widgets/services_list.dart";

class ServicesScreen extends StatelessWidget {
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
