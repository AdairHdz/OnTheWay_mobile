import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewRateScreen extends StatelessWidget {
  var _TiposDeServicio = [
    'Compra de víveres',
    'Compra de fármacos',
    'Entrega de mercancía'
  ];
  var _Ciudades = ['Ciudad_1', 'Ciudad_2', 'Ciudad_3'];
  var _Sectores = ['Sector_1', 'Sector_2', 'Sector_3'];
  String _typeService = 'Tipo de servicio';
  String _city = 'Ciudad';
  String _sector = 'Sector';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("On The Way"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  /*Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                    ),
                  ),*/
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Nueva tarifa',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButton(
                        //value: _typeService,
                        hint: Text(_typeService),
                        items: _TiposDeServicio.map<DropdownMenuItem<String>>(
                            (String servicio) {
                          return DropdownMenuItem<String>(
                              value: servicio, child: Text(servicio));
                        }).toList(),
                        onChanged: (_value) => {
                          setState(() {
                            _typeService = _value;
                          })
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButton(
                        //value: _city,
                        hint: Text(_city),
                        items: _Ciudades.map<DropdownMenuItem<String>>(
                            (String ciudad) {
                          return DropdownMenuItem<String>(
                              value: ciudad, child: Text(ciudad));
                        }).toList(),
                        onChanged: (_value) => {
                          setState(() {
                            _city = _value;
                          })
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButton(
                        //value: _sector,
                        hint: Text(_sector),
                        items: _Sectores.map<DropdownMenuItem<String>>(
                            (String sector) {
                          return DropdownMenuItem<String>(
                              value: sector, child: Text(sector));
                        }).toList(),
                        onChanged: (_value) => {
                          setState(() {
                            _sector = _value;
                          })
                        },
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Tarifa"),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.orange,
                        textColor: Colors.white,
                        child: Text("Aceptar"),
                        onPressed: () {},
                      ),
                      RaisedButton(
                        color: Colors.orange,
                        textColor: Colors.white,
                        child: Text("Cancelar"),
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  setState(Null Function() param0) {}
}
