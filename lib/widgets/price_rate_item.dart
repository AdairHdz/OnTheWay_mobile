import "package:flutter/material.dart";
import 'package:on_the_way_mobile/widgets/weekdayCircle.dart';

class PriceRateItem extends StatelessWidget {
  final String cityName;
  final List<int> weekdays;
  final int kindOfService;
  final String startingHour;
  final String endingHour;
  final double priceRate;

  const PriceRateItem({
    this.weekdays,
    this.startingHour,
    this.endingHour,
    this.priceRate,
    this.cityName,
    this.kindOfService,
  });

  String get kindOfServiceName {
    String kindOfServiceName = "";
    switch (kindOfService) {
      case 0:
        kindOfServiceName = "Pago de servicios";
        break;
      case 1:
        kindOfServiceName = "Compra de fármacos";
        break;
      case 2:
        kindOfServiceName = "Compra de víveres";
        break;
      case 3:
        kindOfServiceName = "Entrega";
        break;
      case 4:
        kindOfServiceName = "Otro";
        break;
    }
    return kindOfServiceName;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    children: [for (var item in weekdays) WeekdayCircle(item)],
                  ),
                  Text(
                    cityName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "\$$priceRate MXN",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "$startingHour - $endingHour",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    kindOfServiceName,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
