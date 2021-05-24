import "package:flutter/material.dart";
import 'package:on_the_way_mobile/data/dataTransferObjects/priceRateDTO/priceRateResponseDTO.dart';
import "../widgets/price_rate_item.dart";

class PriceRate extends StatelessWidget {
  final List<PriceRateResponseDTO> priceRates;

  const PriceRate(this.priceRates);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          children: [
            if (priceRates != null)
              for (var priceRate in priceRates)
                PriceRateItem(
                  cityName: priceRate.city.name,
                  startingHour: priceRate.startingHour,
                  endingHour: priceRate.endingHour,
                  kindOfService: priceRate.kindOfService,
                  weekdays: priceRate.workingDays,
                  priceRate: priceRate.price,
                ),
            if (priceRates == null)
              Text("Parece que aún no tienes tarifas agregadas")
          ],
        ),
      ),
    );
  }
}
