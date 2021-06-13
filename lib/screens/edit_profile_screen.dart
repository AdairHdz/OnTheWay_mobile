import 'dart:async';
import 'dart:convert';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:on_the_way_mobile/data/restRequest/restRequest.dart';
import 'package:on_the_way_mobile/helpers/customExceptions/networkRequestException.dart';
import 'package:on_the_way_mobile/helpers/notifier.dart';
import 'package:on_the_way_mobile/helpers/sessionManager/Session.dart';
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

  Image noImage = Image.asset("assets/images/OnTheWay.png");

  String imageUrl = "";
  String imagePath = "";

  Future<void> _getImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    //final image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        noImage = Image.file(File(pickedFile.path));
        imagePath = pickedFile.path;
        _sendImage();
      }
    });
  }

  Future<void> _sendImage() async {
    RestRequest request = RestRequest();
    try {
      var response = await request.putImageResource(
          "/v1/providers/${Session().id}/image", imagePath);
      if (response.statusCode == 200) {
        Map<String, dynamic> loginResponseMap = jsonDecode(response.body);
        print(loginResponseMap);
      }
    } on TimeoutException catch (_) {
      showNotification(
          context,
          "Se ha agotado el tiempo de espera",
          "El servidor ha tardado demasiado en responder. Por favor, intente más tarde",
          "Aceptar");
    } on NetworkRequestException catch (error) {
      showNotification(
          context, "Ha ocurrido un error de red", error.cause, "Aceptar");
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    var listStates = ['Veracruz', 'Oaxaca', 'Puebla'];
    String _view = 'Estado';

    return Scaffold(
        appBar: AppBar(
          title: Text("Editar perfil"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  SizedBox(
                    width: deviceWidth,
                    height: (deviceHeight * 0.30),
                    child: FittedBox(
                      child: (imageUrl !=
                              null) // Only use the network image if the url is not null
                          ? Image.network(
                              imageUrl,
                              loadingBuilder:
                                  (context, child, loadingProgress) =>
                                      (loadingProgress == null)
                                          ? child
                                          : CircularProgressIndicator(),
                              errorBuilder: (context, error, stackTrace) =>
                                  noImage,
                            )
                          : noImage,
                      fit: BoxFit.fill,
                    ),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(labelText: "Nombres"),
                          validator: (value) {
                            var isValidData = new RegExp(r"[A-z ]{1,50}",
                                    caseSensitive: false)
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
                            var isValidData = new RegExp(r"[A-z ]{1,50}",
                                    caseSensitive: false)
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
                        SizedBox(
                          height: 30,
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
