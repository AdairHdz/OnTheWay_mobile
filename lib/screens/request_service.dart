import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

class RequestService extends StatefulWidget {
  static final String routeName = "/request_service";
  @override
  _RequestServiceState createState() => _RequestServiceState();
}

@override
class _RequestServiceState extends State<RequestService> {
  final _form = GlobalKey<FormState>();

  void _saveForm(bool confirmed) {
    if (_form.currentState.validate()) {
      if (confirmed) {
        _form.currentState.save();
        _showMyDialogReady();
      }
    } else {
      print("XD");
    }
  }

  Future<void> _showMyDialogReady() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Éxito"),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text('Información del pedido enviada'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Confirmar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/homesr");
                  },
                )
              ]);
        });
  }

  bool predeterminated = false;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Solicitud de servicio"),
        ),
        body: Container(
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all((Radius.circular(0.5))),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ]),
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            Container(
                margin: EdgeInsets.only(
                  left: 10,
                  top: 20,
                  right: 10,
                  bottom: 20,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Solicitud de servicio",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                )),
            Container(
              margin: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Edgar Hernández Viveros",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(40),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Datos de envío",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 30),
                ),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Checkbox(
                          checkColor: Theme.of(context).primaryColor,
                          activeColor: Theme.of(context).accentColor,
                          value: predeterminated,
                          onChanged: (bool value) {
                            setState(() {
                              this.predeterminated = value;
                            });
                          }),
                      SizedBox(
                          width: 200,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Utilizar la dirección predeterminada",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(30),
              child: Align(
                alignment: Alignment.center,
                child: Form(
                  key: _form,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Por favor, rellene el campo";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Nombre",
                            labelStyle: TextStyle(fontSize: 20)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Por favor, rellene el campo";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Calle",
                            labelStyle: TextStyle(fontSize: 20)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Por favor, rellene el campo";
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: "No. Int.",
                                  labelStyle: TextStyle(fontSize: 20)),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Por favor, rellene el campo";
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: "No Ext.",
                                  labelStyle: TextStyle(fontSize: 20)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Por favor, rellene el campo";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Municipio",
                            labelStyle: TextStyle(fontSize: 20)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            labelText: "Tipo de servicio",
                            labelStyle: TextStyle(fontSize: 20)),
                        items: [
                          "Entrega",
                          "Compra de víveres",
                          "Compra de fármacos",
                          "Otro"
                        ]
                            .map((label) => DropdownMenuItem(
                                child: Text(label), value: label))
                            .toList(),
                        onChanged: (_) {},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            labelText: "Región",
                            labelStyle: TextStyle(fontSize: 20)),
                        items: [
                          "Coatepec",
                          "Xalapa",
                          "Banderilla",
                          "Emiliano Zapata"
                        ]
                            .map((label) => DropdownMenuItem(
                                child: Text(label), value: label))
                            .toList(),
                        onChanged: (_) {},
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "Descripción",
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 40, horizontal: 0),
                            labelStyle: TextStyle(fontSize: 20)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.orange, onPrimary: Colors.black),
                          child: Text("Confirmar",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          onPressed: () async {
                            if (_form.currentState.validate()) {
                              if (await confirm(context,
                                  title: Text("Confirmación"),
                                  content: Text(
                                      "¿Desea confirmar los datos del pedido?"),
                                  textOK: Text("Sí"),
                                  textCancel: Text("No"))) {
                                return _saveForm(true);
                              }
                              return print("No");
                            }
                          })
                    ],
                  ),
                ),
              ),
            )
          ])),
        ));
  }
}
