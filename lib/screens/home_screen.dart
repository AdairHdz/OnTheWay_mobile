import 'dart:async';
import 'dart:convert';

import "package:flutter/material.dart";
import 'package:on_the_way_mobile/data/dataTransferObjects/serviceProviderDTO/serviceProviderDTO.dart';
import 'package:on_the_way_mobile/data/restRequest/restRequest.dart';
import 'package:on_the_way_mobile/helpers/customExceptions/networkRequestException.dart';
import 'package:on_the_way_mobile/helpers/notifier.dart';
import 'package:on_the_way_mobile/helpers/sessionManager/Session.dart';
import 'package:on_the_way_mobile/widgets/price_rate.dart';
import 'package:on_the_way_mobile/widgets/profile_info.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ServiceProviderDTO _serviceProviderDTO = ServiceProviderDTO(
      names: "...",
      lastName: "...",
      emailAddress: "...",
      averageScore: 0,
      priceRates: new List.empty(growable: true),
      profileImage: "");

  void navigateToPriceRateRegistry(BuildContext context) {
    Navigator.of(context).pushNamed("/price-rate");
  }

  Future<void> _getServiceProviderData() async {
    RestRequest request = RestRequest();
    try {
      var response =
          await request.getResource("/v1/providers/${Session().id}", true);
      Map<String, dynamic> serviceProviderMap = jsonDecode(response.body);
      setState(() {
        _serviceProviderDTO = ServiceProviderDTO.fromJson(serviceProviderMap);
        Session session = Session();
        session.profilePicture = _serviceProviderDTO.profileImage;
      });
    } on TimeoutException catch (_) {
      showNotification(
          context,
          "Se ha agotado el tiempo de espera",
          "El servidor ha tardado demasiado en responder. Por favor, intente más tarde",
          "Aceptar");
    } on NetworkRequestException catch (error) {
      showNotification(
          context, "Ha ocurrido un error de red", error.cause, "Aceptar");
    }
  }

  @override
  void initState() {
    super.initState();
    _getServiceProviderData();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          foregroundColor: Colors.white,
          onPressed: () => navigateToPriceRateRegistry(context),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProfileInfo(
                serviceProviderName: _serviceProviderDTO.names +
                    " " +
                    _serviceProviderDTO.lastName,
                averageScore: _serviceProviderDTO.averageScore,
                profileImage: _serviceProviderDTO.profileImage,
              ),
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
                      PriceRate(_serviceProviderDTO.priceRates)
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
