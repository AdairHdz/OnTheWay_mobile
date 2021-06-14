import 'dart:async';

import "package:flutter/material.dart";
import 'package:on_the_way_mobile/data/restRequest/restRequest.dart';
import 'package:on_the_way_mobile/helpers/customExceptions/networkRequestException.dart';
import 'package:on_the_way_mobile/helpers/notifier.dart';
import 'package:on_the_way_mobile/helpers/sessionManager/Session.dart';
import 'package:on_the_way_mobile/widgets/accent_button.dart';

class ActivationAccountScreen extends StatefulWidget {
  static final String routeName = "/activation-account";
  const ActivationAccountScreen({Key key}) : super(key: key);

  @override
  _ActivationAccountScreenState createState() =>
      _ActivationAccountScreenState();
}

String verificationCode = "";

class _ActivationAccountScreenState extends State<ActivationAccountScreen> {
  final _form = GlobalKey<FormState>();
  final _emailForm = GlobalKey<FormState>();
  String emailAddress = "";

  Future<void> sendEmail() async {
    RestRequest restRequest = new RestRequest();
    Map<String, String> emailAddressRequest = {"emailAddress": emailAddress};
    await restRequest.putResource(
        "/v1/users/${Session().userId}/verify", emailAddressRequest, true);
    showNotification(
        context,
        "Código enviado",
        "Hemos enviado un código de recuperación a su correo electrónico.",
        "Aceptar");
  }

  void navigateToHomeScreen(BuildContext context) {
    Navigator.of(context).pushNamed("/home");
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _activateAccount() async {
      RestRequest request = RestRequest();
      try {
        Map<String, String> verificationCodeRequest = {
          "verificationCode": verificationCode
        };
        var response = await request.patchResource(
            "/v1/users/${Session().userId}/verify",
            verificationCodeRequest,
            true);
        if (response.statusCode == 200) {
          await showNotification(context, "Cuenta activada",
              "Su cuenta se ha activado exitosamente.", "Aceptar");
          navigateToHomeScreen(context);
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

    void _saveForm() {
      bool dataIsValid = _form.currentState.validate();
      if (dataIsValid) {
        _form.currentState.save();
        _activateAccount();
      }
    }

    void _saveEmailForm() {
      bool dataIsValid = _emailForm.currentState.validate();
      if (dataIsValid) {
        _emailForm.currentState.save();
        sendEmail();
      }
    }

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
                          "Activar cuenta",
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
                                    labelText: "Código de verificación"),
                                validator: (value) {
                                  var isValidData = value.length == 8;
                                  if (isValidData) {
                                    return null;
                                  }
                                  return "Código inválido";
                                },
                                onSaved: (value) {
                                  verificationCode = value;
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              AccentButton(_saveForm, "Activar cuenta"),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                        Form(
                            key: _emailForm,
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
                                    emailAddress = value;
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                AccentButton(_saveEmailForm, "Reenviar código"),
                              ],
                            ))
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
    ));
  }
}
