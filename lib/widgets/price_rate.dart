import 'dart:async';

import "package:flutter/material.dart";
import 'package:on_the_way_mobile/data/dataTransferObjects/priceRateDTO/priceRateResponseDTO.dart';
import 'package:on_the_way_mobile/data/restRequest/restRequest.dart';
import 'package:on_the_way_mobile/helpers/customExceptions/networkRequestException.dart';
import 'package:on_the_way_mobile/helpers/notifier.dart';
import 'package:on_the_way_mobile/helpers/sessionManager/Session.dart';
import "../widgets/price_rate_item.dart";

class PriceRate extends StatefulWidget {
  final List<PriceRateResponseDTO> priceRates;

  const PriceRate(this.priceRates);

  @override
  _PriceRateState createState() => _PriceRateState();
}

class _PriceRateState extends State<PriceRate> {
  Future<void> deletePriceRate(int index, String priceRateId) async {
    RestRequest request = RestRequest();
    try {
      await request.deleteResource(
          "/v1/providers/${Session().id}/priceRates/$priceRateId", true);
      setState(() {
        widget.priceRates.removeAt(index);
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 300,
        child: widget.priceRates == null || widget.priceRates.length == 0
            ? Text("Parece que aún no tienes tarifas agregadas")
            : ListView.builder(
                itemCount:
                    widget.priceRates == null ? 0 : widget.priceRates.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      if (widget.priceRates != null)
                        Dismissible(
                          child: PriceRateItem(
                            cityName: widget.priceRates[index].city.name,
                            startingHour: widget.priceRates[index].startingHour,
                            endingHour: widget.priceRates[index].endingHour,
                            kindOfService:
                                widget.priceRates[index].kindOfService,
                            weekdays: widget.priceRates[index].workingDays,
                            priceRate: widget.priceRates[index].price,
                          ),
                          key: ValueKey<String>(widget.priceRates[index].id),
                          onDismissed: (DismissDirection direction) {
                            deletePriceRate(index, widget.priceRates[index].id);
                          },
                          direction: DismissDirection.endToStart,
                          background: Container(color: Colors.redAccent),
                        ),
                    ],
                  );
                }),
      ),
    );
  }
}
