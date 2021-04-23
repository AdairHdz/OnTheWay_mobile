import "package:flutter/material.dart";
import "../widgets/price_rate_item.dart";

class PriceRate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          children: [
            PriceRateItem(
              day: "Lunes",
              startingHour: "07:00 AM",
              endingHour: "03:00 PM",
              priceRate: 80,
            ),
            PriceRateItem(
              day: "Martes",
              startingHour: "09:00 AM",
              endingHour: "06:00 PM",
              priceRate: 50,
            ),
          ],
        ),
      ),
    );
  }
}
