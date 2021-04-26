import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:on_the_way_mobile/widgets/custom_dropdown_button.dart';
import "package:weekday_selector/weekday_selector.dart";

class PriceRateRegistrationScreen extends StatefulWidget {
  static final String routeName = "/price-rate";

  @override
  _PriceRateRegistrationScreenState createState() =>
      _PriceRateRegistrationScreenState();
}

class _PriceRateRegistrationScreenState
    extends State<PriceRateRegistrationScreen> {
  final _form = GlobalKey<FormState>();
  final List<bool> _selectedDays = List.filled(7, false);
  TimeOfDay _startingHour = TimeOfDay.now();
  TimeOfDay _endingHour = TimeOfDay.now();

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text("No ha seleccionado días de trabajo"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Por favor seleccione uno o más días de trabajo"),
              ],
            ),
          ),
          actions: [
            TextButton(
                child: Text("Aceptar"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  void _saveForm() {
    bool dataIsValid = _form.currentState.validate();
    if (_atLeastOneDayHasBeenSelected()) {
      if (dataIsValid) {
        _form.currentState.save();
      }
    } else {
      _showMyDialog(context);
    }
  }

  void setDaySelected(int day) {
    setState(() {
      final index = day % 7;
      _selectedDays[index] = !_selectedDays[index];
    });
  }

  bool _atLeastOneDayHasBeenSelected() {
    return _selectedDays.contains(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of services"),
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Center(
            child: Text(
              "Nueva tarifa",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          SizedBox(height: 30),
          Form(
            key: _form,
            child: SizedBox(
              width: 300,
              child: Column(
                children: [
                  WeekdaySelector(
                      onChanged: (day) => setDaySelected(day),
                      values: _selectedDays),
                  SizedBox(height: 30),
                  CustomDropdownButton(
                    hint: "Estado",
                    options: ["Veracruz", "Puebla"],
                  ),
                  SizedBox(height: 30),
                  CustomDropdownButton(
                    hint: "Ciudad",
                    options: ["Xalapa", "Coatepec", "Xico"],
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Tarifa"),
                    validator: (value) {
                      var isValidData = new RegExp(r"^\d{1,4}(?:[.]\d{1,2})?$",
                              caseSensitive: false)
                          .hasMatch(value.trim());
                      if (isValidData) {
                        return null;
                      }
                      return "Número no válido";
                    },
                  ),
                  SizedBox(height: 30),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Desde",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                )),
                            SizedBox(height: 20),
                            GestureDetector(
                              child: Text(_startingHour.format(context)),
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  if (value == null) {
                                    return;
                                  }
                                  setState(() {
                                    _startingHour = value;
                                  });
                                });
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Hasta",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                )),
                            SizedBox(height: 20),
                            GestureDetector(
                              child: Text(_endingHour.format(context)),
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  if (value == null) {
                                    return;
                                  }
                                  setState(() {
                                    _endingHour = value;
                                  });
                                });
                              },
                            ),
                          ],
                        )
                      ]),
                  SizedBox(height: 50),
                  Container(
                    width: 130,
                    child: ElevatedButton(
                        child: Text("Aceptar"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).accentColor),
                        ),
                        onPressed: () => _saveForm()),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
