import 'dart:async';
import 'dart:convert';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/cityDTO/cityDTO.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/priceRateDTO/priceRateRequestDTO.dart';
import 'package:on_the_way_mobile/data/restRequest/restRequest.dart';
import 'package:on_the_way_mobile/helpers/customExceptions/networkRequestException.dart';
import 'package:on_the_way_mobile/helpers/notifier.dart';
import 'package:on_the_way_mobile/helpers/sessionManager/Session.dart';
import 'package:on_the_way_mobile/widgets/custom_dropdown_button.dart';
import "package:weekday_selector/weekday_selector.dart";

class PriceRateRegistrationScreen extends StatefulWidget {
  static final String routeName = "/price-rate";

  @override
  _PriceRateRegistrationScreenState createState() =>
      _PriceRateRegistrationScreenState();
}

void _navigateToHomeScreen(BuildContext context) {
  Navigator.of(context).pushNamed("/home");
}

class _PriceRateRegistrationScreenState
    extends State<PriceRateRegistrationScreen> {
  final _form = GlobalKey<FormState>();
  final List<bool> _selectedDays = List.filled(7, false);
  TimeOfDay _startingHour = TimeOfDay.now();
  TimeOfDay _endingHour =
      TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 1)));

  PriceRateRequestDTO _priceRateDTO = PriceRateRequestDTO(
      price: 0,
      kindOfService: 0,
      startingHour: "",
      endingHour: "",
      cityId: "",
      workingDays: null);
  List<CustomInput> listOfCities = List.empty(growable: true);
  List<CustomInput> listOfKindOfServices = List.empty(growable: true);

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

  @override
  void initState() {
    super.initState();
    _fetchCities();
    _priceRateDTO = PriceRateRequestDTO(
        price: 0,
        kindOfService: 0,
        startingHour: formatHour(DateTime.now()),
        endingHour: formatHour(DateTime.now()),
        cityId: "",
        workingDays: null);

    listOfKindOfServices
        .add(CustomInput(child: "Pago de servicios", value: "0"));
    listOfKindOfServices
        .add(CustomInput(child: "Compra de fármacos", value: "1"));
    listOfKindOfServices
        .add(CustomInput(child: "Compra de víveres", value: "2"));
    listOfKindOfServices.add(CustomInput(child: "Entrega", value: "3"));
    listOfKindOfServices.add(CustomInput(child: "Otro", value: "4"));
  }

  String formatHour(DateTime time) {
    String formattedHour = DateFormat.jm().format(
        new DateTime(time.year, time.month, time.day, time.hour, time.minute));

    return formattedHour;
  }

  void _saveForm() {
    bool dataIsValid = _form.currentState.validate();
    if (_atLeastOneDayHasBeenSelected()) {
      if (dataIsValid) {
        _form.currentState.save();
        List<int> workingDaysToBeSaved = List.empty(growable: true);
        for (int i = 0; i < _selectedDays.length; i++) {
          if (_selectedDays[i]) {
            if (i == 0) {
              workingDaysToBeSaved.add(7);
            } else {
              workingDaysToBeSaved.add(i);
            }
          }
        }
        _priceRateDTO.workingDays = workingDaysToBeSaved;
        _priceRateDTO.startingHour =
            removeWhiteSpaces(_priceRateDTO.startingHour);
        _priceRateDTO.endingHour = removeWhiteSpaces(_priceRateDTO.endingHour);
        _savePriceRate();
      }
    } else {
      _showMyDialog(context);
    }
  }

  String removeWhiteSpaces(String text) {
    return text.replaceAll(" ", "");
  }

  Future<void> _savePriceRate() async {
    RestRequest request = RestRequest();
    Session mySession = Session();
    try {
      var response = await request.postResource(
          "/v1.0.0/providers/${mySession.id}/priceRates", _priceRateDTO, true);
      if (response.statusCode == 201) {
        showNotification(context, "Tarifa registrada",
            "La tarifa se ha registrado de forma exitosa", "Aceptar");
      }
    } on TimeoutException catch (_) {
      showNotification(
          context,
          "Se ha agotado el tiempo de espera",
          "El servidor ha tardado demasiado en responder. Por favor, intente más tarde",
          "Aceptar");
    } on NetworkRequestException catch (error) {
      String exceptionMessage;
      switch (error.httpCode) {
        case 400:
          exceptionMessage =
              "Por favor asegúrese de haber introducido información válida e intente nuevamente.";
          break;
        case 401:
          exceptionMessage = "Lo sentimos; su sesión ha expirado.";
          break;
        case 409:
          exceptionMessage =
              "Lo sentimos; ha ocurrido un error al intentar procesar su solicitud.";
          break;
        default:
          exceptionMessage =
              "Ha ocurrido un error desconocido. Por favor, intente más tarde.}.";
          break;
      }
      showNotification(context, "Error", exceptionMessage, "Aceptar");
    }
  }

  Future<void> _fetchCities() async {
    RestRequest request = RestRequest();
    Session mySession = Session();
    try {
      var response = await request.getResource(
          "/v1.0.0/states/${mySession.stateId}/cities", false);
      if (response.statusCode == 200) {
        List<CityDTO> listOfCitiesDTO = (jsonDecode(response.body) as List)
            .map((i) => CityDTO.fromJson(i))
            .toList();
        listOfCitiesDTO.forEach((cityDTO) {
          setState(() {
            CustomInput customInput =
                CustomInput(child: cityDTO.name, value: cityDTO.id);
            listOfCities.add(customInput);
          });
        });
      }
    } on TimeoutException catch (_) {
      showNotification(
          context,
          "Se ha agotado el tiempo de espera",
          "El servidor ha tardado demasiado en responder. Por favor, intente más tarde",
          "Aceptar");
    } on NetworkRequestException catch (error) {
      String exceptionMessage;
      switch (error.httpCode) {
        case 400:
          exceptionMessage =
              "Por favor asegúrese de haber introducido información válida e intente nuevamente.";
          break;
        case 404:
          exceptionMessage =
              "Lo sentimos. Parece que OnTheWay no cuenta con ciudades registradas para su Estado.";
          break;
        case 409:
          exceptionMessage =
              "Lo sentimos; ha ocurrido un error al intentar procesar su solicitud.";
          break;
        default:
          exceptionMessage =
              "Ha ocurrido un error desconocido. Por favor, intente m{as tarde.}.";
          break;
      }
      showNotification(context, "Error", exceptionMessage, "Aceptar");
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
      body: SingleChildScrollView(
        child: Column(
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
                    SizedBox(height: 30),
                    DropdownButtonFormField(
                      hint: Text("Ciudad"),
                      items: [
                        if (listOfCities != null && listOfCities.isNotEmpty)
                          ...listOfCities.map(
                            (option) {
                              return DropdownMenuItem(
                                child: Text(option.child),
                                value: option.value,
                              );
                            },
                          )
                      ],
                      validator: (value) {
                        if (value == null) {
                          return "Seleccione una ciudad";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _priceRateDTO = PriceRateRequestDTO(
                            price: _priceRateDTO.price,
                            kindOfService: _priceRateDTO.kindOfService,
                            startingHour: _priceRateDTO.startingHour,
                            endingHour: _priceRateDTO.endingHour,
                            cityId: value,
                            workingDays: _priceRateDTO.workingDays);
                      },
                    ),
                    SizedBox(height: 30),
                    DropdownButtonFormField(
                      hint: Text("Tipo de servicio"),
                      items: [
                        if (listOfKindOfServices != null &&
                            listOfKindOfServices.isNotEmpty)
                          ...listOfKindOfServices.map(
                            (option) {
                              return DropdownMenuItem(
                                child: Text(option.child),
                                value: option.value,
                              );
                            },
                          )
                      ],
                      validator: (value) {
                        if (value == null) {
                          return "Seleccione un tipo de servicio";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _priceRateDTO = PriceRateRequestDTO(
                            price: _priceRateDTO.price,
                            kindOfService: int.parse(value),
                            startingHour: _priceRateDTO.startingHour,
                            endingHour: _priceRateDTO.endingHour,
                            cityId: _priceRateDTO.cityId,
                            workingDays: _priceRateDTO.workingDays);
                      },
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: "Tarifa"),
                      validator: (value) {
                        var isValidData = new RegExp(
                                r"^\d{1,4}(?:[.]\d{1,2})?$",
                                caseSensitive: false)
                            .hasMatch(value.trim());

                        if (!isValidData) {
                          return "Tarifa no válida";
                        }

                        double parsedPriceRate = double.parse(value);

                        if (parsedPriceRate <= 0) {
                          return "La tarifa no puede ser igual o menor a 0";
                        }

                        if (parsedPriceRate > 100) {
                          return "No se permiten tarifas con un valor mayor a \$100.00 MXN";
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _priceRateDTO = PriceRateRequestDTO(
                            price: double.parse(value),
                            kindOfService: _priceRateDTO.kindOfService,
                            startingHour: _priceRateDTO.startingHour,
                            endingHour: _priceRateDTO.endingHour,
                            cityId: _priceRateDTO.cityId,
                            workingDays: _priceRateDTO.workingDays);
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
                                    initialTime: _startingHour,
                                  ).then((value) {
                                    if (value == null) {
                                      return;
                                    }
                                    setState(() {
                                      final now = new DateTime.now();
                                      String formattedStartingHour =
                                          DateFormat.jm().format(new DateTime(
                                              now.year,
                                              now.month,
                                              now.day,
                                              value.hour,
                                              value.minute));

                                      _priceRateDTO = PriceRateRequestDTO(
                                          price: _priceRateDTO.price,
                                          kindOfService:
                                              _priceRateDTO.kindOfService,
                                          startingHour: formattedStartingHour,
                                          endingHour: _priceRateDTO.endingHour,
                                          cityId: _priceRateDTO.cityId,
                                          workingDays:
                                              _priceRateDTO.workingDays);
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
                                    initialTime: _endingHour,
                                  ).then((value) {
                                    if (value == null) {
                                      return;
                                    }
                                    setState(() {
                                      final now = new DateTime.now();
                                      String formattedEndingHour =
                                          DateFormat.jm().format(new DateTime(
                                              now.year,
                                              now.month,
                                              now.day,
                                              value.hour,
                                              value.minute));

                                      _priceRateDTO = PriceRateRequestDTO(
                                          price: _priceRateDTO.price,
                                          kindOfService:
                                              _priceRateDTO.kindOfService,
                                          startingHour:
                                              _priceRateDTO.startingHour,
                                          endingHour: formattedEndingHour,
                                          cityId: _priceRateDTO.cityId,
                                          workingDays:
                                              _priceRateDTO.workingDays);
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
                          onPressed: () {
                            _saveForm();
                            _navigateToHomeScreen(context);
                          }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
