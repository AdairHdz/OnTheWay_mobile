import 'dart:async';
import 'dart:convert';

import "package:flutter/material.dart";
import 'package:on_the_way_mobile/helpers/notifier.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/loginRequestDTO.dart';
import 'package:on_the_way_mobile/data/dataTransferObjects/loginResponseDTO.dart';
import 'package:on_the_way_mobile/data/restRequest/restRequest.dart';
import 'package:on_the_way_mobile/helpers/customExceptions/networkRequestException.dart';
import 'package:on_the_way_mobile/helpers/sessionManager/Session.dart';
import 'package:on_the_way_mobile/screens/activation_account_screen.dart';
import 'package:on_the_way_mobile/screens/reset_password_screen.dart';
import 'package:on_the_way_mobile/widgets/accent_button.dart';

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

  void navigateToHomeScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed("/home");
  }

  void navigateToActivationAccountScreen(BuildContext context) {
    Navigator.of(context).pushNamed(ActivationAccountScreen.routeName);
  }

  Future<void> _loginUser() async {
    RestRequest request = RestRequest();
    try {
      var response =
          await request.postResource("/v1.0.0/login", _loginRequestDTO, false);
      if (response.statusCode == 200) {
        Map<String, dynamic> loginResponseMap = jsonDecode(response.body);
        LoginResponseDTO loginResponse =
            LoginResponseDTO.fromJson(loginResponseMap);
        Session mySession = Session();
        mySession.id = loginResponse.id;
        mySession.userId = loginResponse.userId;
        mySession.names = loginResponse.names;
        mySession.lastName = loginResponse.lastName;
        mySession.emailAddress = loginResponse.emailAddress;
        mySession.verified = loginResponse.verified;
        mySession.userType = loginResponse.userType;
        mySession.token = loginResponse.token;
        mySession.refreshToken = loginResponse.refreshToken;
        mySession.stateId = loginResponse.stateId;

        if (loginResponse.verified) {
          navigateToHomeScreen(context);
        } else {
          navigateToActivationAccountScreen(context);
        }
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
          exceptionMessage =
              "Dirección de correo electrónico o contraseña incorrecta.";
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

  void _goToResetPassword() {
    Navigator.of(context).pushNamed(ResetPasswordScreen.routeName);
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
