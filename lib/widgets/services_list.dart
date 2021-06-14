import 'package:flutter/material.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/serviceRequestDTO/serviceRequestDTO.dart';
import 'package:on_the_way_mobile/widgets/service_item.dart';

class ServicesList extends StatelessWidget {
  final int selectedService = 0;
  final List<ServiceRequestDTO> serviceRequests;
  ServicesList({this.serviceRequests});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            child: SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: serviceRequests.length,
                itemBuilder: (buildContext, index) {
                  return ServiceItem(serviceRequests[index]);
                },
              ),
            ),
          )),
    );
  }
}
