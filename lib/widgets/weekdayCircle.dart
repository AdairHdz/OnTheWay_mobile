import "package:flutter/material.dart";

class WeekdayCircle extends StatelessWidget {
  final int weekday;

  WeekdayCircle(this.weekday);

  String _getWeekdayName(int weekday) {
    String weekdayName = "";
    switch (weekday) {
      case 1:
        weekdayName = "Lunes";
        break;
      case 2:
        weekdayName = "Martes";
        break;
      case 3:
        weekdayName = "Miércoles";
        break;
      case 4:
        weekdayName = "Jueves";
        break;
      case 5:
        weekdayName = "Viernes";
        break;
      case 6:
        weekdayName = "Sábado";
        break;
      case 7:
        weekdayName = "Domingo";
        break;
    }
    return weekdayName;
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: _getWeekdayName(weekday),
      waitDuration: Duration(microseconds: 0),
      child: Container(
        width: 30,
        height: 30,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Theme.of(context).primaryColor),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            _getWeekdayName(weekday).substring(0, 1),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
