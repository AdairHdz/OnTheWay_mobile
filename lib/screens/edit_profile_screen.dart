import 'dart:async';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/serviceProviderEditionDTO/serviceProviderEditionDTO.dart';
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
  ServiceProviderEditionDTO serviceProviderEditionDTO =
      ServiceProviderEditionDTO(names: "", lastName: "");
  void _saveForm() {
    bool dataIsValid = _form.currentState.validate();
    if (dataIsValid) {
      _form.currentState.save();
      _updateProfile();
    } else {
      _showMyDialog(context, "“Los campos de texto son inválidos");
    }
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
  Session session = Session();
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

  Future<void> _updateProfile() async {
    RestRequest request = RestRequest();
    try {
      Session session = Session();
      var response = await request.patchResource(
          "/v1/providers/${session.id}", serviceProviderEditionDTO, true);
      if (response.statusCode == 200) {
        showNotification(context, "Información actualizada",
            "Sus datos se han actualizado correctamente.", "Aceptar");
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

  Future<void> _sendImage() async {
    RestRequest request = RestRequest();
    try {
      await request.putImageResource(
          "/v1/providers/${Session().id}/image", imagePath);
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
              "Ha ocurrido un error desconocido. Por favor, intente m{as tarde.}.";
          break;
      }
      showNotification(context, "Error", exceptionMessage, "Aceptar");
    }
  }

  @override
  void initState() {
    super.initState();
    imagePath =
        "http://192.168.100.173:8080/images/${session.id}/${session.profilePicture}";
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

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
                      child: (imagePath !=
                              null) // Only use the network image if the url is not null
                          ? Image.network(
                              imagePath,
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
                          initialValue: Session().names,
                          validator: (value) {
                            var isValidData = new RegExp(r"[A-z ]{1,50}",
                                    caseSensitive: false)
                                .hasMatch(value.trim());
                            if (isValidData) {
                              return null;
                            }
                            return "Por favor inserte solo letras y espacios en blanco";
                          },
                          onSaved: (value) {
                            serviceProviderEditionDTO =
                                ServiceProviderEditionDTO(
                                    names: value,
                                    lastName:
                                        serviceProviderEditionDTO.lastName);
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Apellidos"),
                          initialValue: Session().lastName,
                          validator: (value) {
                            var isValidData = new RegExp(r"[A-z ]{1,50}",
                                    caseSensitive: false)
                                .hasMatch(value.trim());
                            if (isValidData) {
                              return null;
                            }
                            return "Por favor inserte solo letras y espacios en blanco";
                          },
                          onChanged: (value) {
                            serviceProviderEditionDTO =
                                ServiceProviderEditionDTO(
                                    names: serviceProviderEditionDTO.names,
                                    lastName: value);
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
                        AccentButton(_saveForm, "Aceptar"),
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
