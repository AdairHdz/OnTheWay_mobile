import 'dart:async';

import "package:flutter/material.dart";
import 'package:on_the_way_mobile/data/dataTransferObjects/passwordRecoveryDTO.dart';
import 'package:on_the_way_mobile/data/restRequest/restRequest.dart';
import 'package:on_the_way_mobile/helpers/customExceptions/networkRequestException.dart';
import 'package:on_the_way_mobile/helpers/notifier.dart';
import 'package:on_the_way_mobile/widgets/accent_button.dart';

class ResetPasswordScreen2 extends StatefulWidget {
  static final String routeName = "/reset-password2";
  @override
  _ResetPasswordScreenState2 createState() => _ResetPasswordScreenState2();
}

class _ResetPasswordScreenState2 extends State<ResetPasswordScreen2> {
  final _form = GlobalKey<FormState>();

  PasswordRecoveryDTO passwordRecoveryDTO = PasswordRecoveryDTO("", "", "");
  void _saveForm() {
    bool dataIsValid = _form.currentState.validate();
    if (dataIsValid) {
      _form.currentState.save();
      _restablishPassword();
    }
  }

  Future<void> _restablishPassword() async {
    RestRequest request = RestRequest();
    try {
      var response = await request.patchResource(
          "/v1/users/password", passwordRecoveryDTO, true);
      if (response.statusCode == 200) {
        showNotification(context, "Contraseña restablecida.",
            "Su contraseña ha sido restablecida exitosamente.", "Aceptar.");
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

  Widget build(BuildContext context) {
    String emailAddress = ModalRoute.of(context).settings.arguments as String;
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          //color: Theme.of(context).primaryColor,
          color: Colors.white,
          height: (deviceHeight + 50),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: Container(
                  width: deviceWidth,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 30),
                      child: Column(
                        children: [
                          // Se puede eliminar
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
                            "Recuperar contraseña",
                            style: Theme.of(context).textTheme.headline1,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Ingrese el código de verificación enviado a su correo electrónico",
                            style: Theme.of(context).textTheme.bodyText2,
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
                                    return "Código de verificación invalido";
                                  },
                                  onSaved: (value) {
                                    passwordRecoveryDTO = PasswordRecoveryDTO(
                                        passwordRecoveryDTO.emailAddress,
                                        value,
                                        passwordRecoveryDTO.newPassword);
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText:
                                          "Dirección de correo electrónico"),
                                  initialValue: emailAddress,
                                  enabled: false,
                                  onSaved: (value) {
                                    passwordRecoveryDTO = PasswordRecoveryDTO(
                                        emailAddress,
                                        passwordRecoveryDTO.recoveryCode,
                                        passwordRecoveryDTO.newPassword);
                                  },
                                  validator: (value) {
                                    var isValidData = new RegExp(
                                            r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                                            caseSensitive: false)
                                        .hasMatch(value.trim());
                                    if (isValidData) {
                                      return null;
                                    }
                                    return "Código de verificación invalido";
                                  },
                                ),
                                TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      labelText: "Nueva contraseña"),
                                  validator: (value) {
                                    String password = value.trim();
                                    if (password.length >= 8 &&
                                        password.length <= 50) {
                                      return null;
                                    }
                                    showNotification(
                                        context,
                                        "Contaseña insegura",
                                        "Por favor ingrese una contraseña con al menos 8 caracteres",
                                        "Aceptar");
                                    return "Contraseña inválida";
                                  },
                                  onSaved: (value) {
                                    passwordRecoveryDTO = PasswordRecoveryDTO(
                                        passwordRecoveryDTO.emailAddress,
                                        passwordRecoveryDTO.recoveryCode,
                                        value);
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          AccentButton(() => _saveForm(), "Confirmar"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
