import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:on_the_way_mobile/widgets/accent_button.dart';

class EditProfileScreen extends StatefulWidget {
  static final String routeName = "/edit-profile";
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _form = GlobalKey<FormState>();

  void _saveForm() {
    bool dataIsValid = _form.currentState.validate();
    if (dataIsValid) {
      _form.currentState.save();
      _showMyDialog(context, "Cambios guardados con exito");
    } else {
      _showMyDialog(context, "“Los campos de texto son inválidos");
    }
  }

  void _saveChanges() {
    _saveForm();
  }

  Future<void> _showMyDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text("Editar perfil"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(message),
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

  Image _image = Image.network(
      "https://images.pexels.com/photos/2611690/pexels-photo-2611690.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940");

  Future<void> _getImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    //final image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile as Image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    var listStates = ['Veracruz', 'Oaxaca', 'Puebla'];
    String _view = 'Estado';

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              SizedBox(
                width: deviceWidth,
                height: (deviceHeight * 0.30),
                child: _image,
              ),
              Positioned(
                top: 0,
                right: deviceWidth / 2,
                child: AccentButton(_getImage, "Editar foto de perfil"),
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Perfil",
              style: Theme.of(context).textTheme.headline1,
            ),
            margin: EdgeInsets.symmetric(vertical: 30),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: "Nombres"),
                      validator: (value) {
                        var isValidData =
                            new RegExp(r"[A-z ]{1,50}", caseSensitive: false)
                                .hasMatch(value.trim());
                        if (isValidData) {
                          print("Valida");
                          return null;
                        }
                        print("Invalida");
                        return "Por favor inserte solo letras y espacios en blanco";
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Apellidos"),
                      validator: (value) {
                        var isValidData =
                            new RegExp(r"[A-z ]{1,50}", caseSensitive: false)
                                .hasMatch(value.trim());
                        if (isValidData) {
                          return null;
                        }
                        return "Por favor inserte solo letras y espacios en blanco";
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Correo"),
                      validator: (value) {
                        var isValidData = new RegExp(
                                r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                                caseSensitive: false)
                            .hasMatch(value.trim());
                        if (isValidData) {
                          return null;
                        }
                        return "Dirección de correo inválida";
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    DropdownButton(
                      items: listStates.map((String _state) {
                        return DropdownMenuItem(
                          value: _state,
                          child: Text(_state),
                        );
                      }).toList(),
                      onChanged: (_value) {
                        setState(() {
                          _view = _value;
                        });
                      },
                      hint: Text(_view),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    AccentButton(_saveChanges, "Aceptar"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
