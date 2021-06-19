import 'dart:developer';
import 'package:flutter/material.dart';
//import 'package:on_the_way_mobile/models/service.dart';
import '../models/service_provider.dart';
import 'package:intl/intl.dart';


class ServiceProviderItem extends StatelessWidget {
  final ServiceProvider serviceProvider;
  ServiceProviderItem(this.serviceProvider);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: () {
        Navigator.of(context).pushNamed( "/home", arguments: {
          
        });
      },
      child: Card(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.person_outline_sharp),
            ),
            title: Text(
            serviceProvider.name + " " + serviceProvider.lastName,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          subtitle: Text(
            "Calificación: " + serviceProvider.rate.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          
      ),
    ),
    );
  }
}