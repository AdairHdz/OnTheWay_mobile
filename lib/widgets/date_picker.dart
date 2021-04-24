import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final String label;
  final Function handler;

  const DatePicker({Key key, this.label, this.handler}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(widget.label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          )),
      SizedBox(height: 20),
      GestureDetector(
          onTap: () {
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.utc(2021, 1, 1),
                    lastDate: DateTime.now())
                .then((value) => widget.handler());
          },
          child: Text(DateFormat.yMMMEd().format(_date))),
    ]);
  }
}
