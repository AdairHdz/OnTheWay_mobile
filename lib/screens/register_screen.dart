import 'dart:async';
import "package:flutter/material.dart";
import 'package:on_the_way_mobile/data/dataTransferObjects/registerRequestDTO.dart';
import 'package:on_the_way_mobile/data/restRequest/restRequest.dart';
import 'package:on_the_way_mobile/helpers/customExceptions/networkRequestException.dart';
import 'package:on_the_way_mobile/widgets/notificationPopup.dart';
import "../widgets/accent_button.dart";

class RegisterScreen extends StatefulWidget {
  static final String routeName = "/register";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  RegisterRequestDTO _registerRequestDTO = RegisterRequestDTO(
      names: "",
      lastName: "",
      emailAddress: "",
      password: "",
      stateId: "3d5b56f8-0e6c-495d-b010-196f26d87e48",
      userType: 0);

  void _saveForm() {
    bool dataIsValid = _form.currentState.validate();
    if (dataIsValid) {
      _form.currentState.save();
      _registerUser();
    }
  }

  Future<void> _registerUser() async {
    RestRequest request = RestRequest();
    try {
      var response =
          await request.postResource("/v1/register", _registerRequestDTO);
      if (response.statusCode == 201) {
        _showNotification(context, "Usuario registrado",
            "El usuario se ha registrado correctamente", "Aceptar");
      }
    } on TimeoutException catch (_) {
      _showNotification(
          context,
          "Se ha agotado el tiempo de espera",
          "El servidor ha tardado demasiado en responder. Por favor, intente más tarde",
          "Aceptar");
    } on NetworkRequestException catch (error) {
      _showNotification(
          context, "Ha ocurrido un error de red", error.cause, "Aceptar");
    }
  }

  Future<void> _showNotification(BuildContext context, String popupTitle,
      String popupBody, String popupButtonText) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext _) {
        return NotificationPopup(
          title: popupTitle,
          body: popupBody,
          buttonText: popupButtonText,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).primaryColor,
          height: (deviceHeight + 50),
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  width: deviceWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 30),
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage(
                              "assets/images/logo-black.png",
                            ),
                            width: 150,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Registro",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Form(
                            key: _form,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "Nombres"),
                                  validator: (value) {
                                    var isValidData = new RegExp(
                                            r"[A-z ]{1,50}",
                                            caseSensitive: false)
                                        .hasMatch(value.trim());
                                    if (isValidData) {
                                      return null;
                                    }
                                    return "Por favor inserte solo letras y espacios en blanco";
                                  },
                                  onSaved: (value) {
                                    _registerRequestDTO = RegisterRequestDTO(
                                        names: value,
                                        lastName: _registerRequestDTO.lastName,
                                        emailAddress:
                                            _registerRequestDTO.emailAddress,
                                        password: _registerRequestDTO.password,
                                        userType: _registerRequestDTO.userType,
                                        stateId: _registerRequestDTO.stateId);
                                  },
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "Apellidos"),
                                  validator: (value) {
                                    var isValidData = new RegExp(
                                            r"[A-z ]{1,50}",
                                            caseSensitive: false)
                                        .hasMatch(value.trim());
                                    if (isValidData) {
                                      return null;
                                    }
                                    return "Por favor inserte solo letras y espacios en blanco";
                                  },
                                  onSaved: (value) {
                                    _registerRequestDTO = RegisterRequestDTO(
                                        names: _registerRequestDTO.names,
                                        lastName: value,
                                        emailAddress:
                                            _registerRequestDTO.emailAddress,
                                        password: _registerRequestDTO.password,
                                        userType: _registerRequestDTO.userType,
                                        stateId: _registerRequestDTO.stateId);
                                  },
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "Correo"),
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
                                  onSaved: (value) {
                                    _registerRequestDTO = RegisterRequestDTO(
                                        names: _registerRequestDTO.names,
                                        lastName: _registerRequestDTO.lastName,
                                        emailAddress: value,
                                        password: _registerRequestDTO.password,
                                        userType: _registerRequestDTO.userType,
                                        stateId: _registerRequestDTO.stateId);
                                  },
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "Contraseña"),
                                  onSaved: (value) {
                                    _registerRequestDTO = RegisterRequestDTO(
                                        names: _registerRequestDTO.names,
                                        lastName: _registerRequestDTO.lastName,
                                        emailAddress:
                                            _registerRequestDTO.emailAddress,
                                        password: value,
                                        userType: _registerRequestDTO.userType,
                                        stateId: _registerRequestDTO.stateId);
                                  },
                                  validator: (value) {
                                    String password = value.trim();
                                    if (password.length >= 8 &&
                                        password.length <= 50) {
                                      return null;
                                    }
                                    _showNotification(
                                        context,
                                        "Contaseña insegura",
                                        "Por favor ingrese una contraseña con al menos 8 caracteres",
                                        "Aceptar");
                                    return "Contraseña inválida";
                                  },
                                  obscureText: true,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          AccentButton(_saveForm, "Iniciar sesión"),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                top: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
