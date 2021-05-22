import 'dart:async';
import 'dart:convert';

import "package:flutter/material.dart";
import 'package:on_the_way_mobile/data/dataTransferObjects/loginRequestDTO.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/loginResponseDTO.dart';
import 'package:on_the_way_mobile/data/restRequest/restRequest.dart';
import 'package:on_the_way_mobile/helpers/customExceptions/networkRequestException.dart';
import 'package:on_the_way_mobile/helpers/sessionManager/Session.dart';
import 'package:on_the_way_mobile/widgets/notificationPopup.dart';
import "../widgets/accent_button.dart";
import "./home_screen.dart";
import "./reset_password_screen.dart";

class LoginScreen extends StatefulWidget {
  static final String routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  LoginRequestDTO _loginRequestDTO =
      LoginRequestDTO(emailAddress: "", password: "");
  void _saveForm() {
    bool dataIsValid = _form.currentState.validate();
    if (dataIsValid) {
      _form.currentState.save();
      _loginUser();
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

  void navigateToHomeScreen(BuildContext context) {
    Navigator.of(context).pushNamed("/home");
  }

  Future<void> _loginUser() async {
    RestRequest request = RestRequest();
    try {
      var response = await request.postResource("/v1/login", _loginRequestDTO);
      if (response.statusCode == 200) {
        Map<String, dynamic> loginResponseMap = jsonDecode(response.body);
        LoginResponseDTO loginResponse =
            LoginResponseDTO.fromJson(loginResponseMap);
        Session mySession = Session();
        mySession.id = loginResponse.id;
        mySession.names = loginResponse.names;
        mySession.lastName = loginResponse.lastName;
        mySession.emailAddress = loginResponse.emailAddress;
        mySession.verified = loginResponse.verified;
        mySession.userType = loginResponse.userType;
        mySession.token = loginResponse.token;
        navigateToHomeScreen(context);
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

  Future<void> _goToHomeScreen(BuildContext context) async {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }

  void _goToResetPassword() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacementNamed(ResetPasswordScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).primaryColor,
          height: deviceHeight,
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  width: deviceWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
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
                            "Login",
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
                                  decoration: InputDecoration(
                                      labelText:
                                          "Dirección de correo electrónico"),
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
                                    _loginRequestDTO = LoginRequestDTO(
                                        emailAddress: value,
                                        password: _loginRequestDTO.password);
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "Contraseña"),
                                  obscureText: true,
                                  onSaved: (value) {
                                    _loginRequestDTO = LoginRequestDTO(
                                        emailAddress:
                                            _loginRequestDTO.emailAddress,
                                        password: value);
                                  },
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextButton(
                            child: Text("¿Olvidaste tu contraseña?"),
                            onPressed: () {
                              _goToResetPassword();
                            },
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.grey),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          AccentButton(() => _saveForm(), "Iniciar sesión"),
                          SizedBox(
                            height: 30,
                          ),
                          TextButton(
                            child: Text("Crear una cuenta"),
                            onPressed: () {},
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                bottom: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
