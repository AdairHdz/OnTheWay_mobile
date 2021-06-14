import "package:flutter/material.dart";
import 'package:on_the_way_mobile/data/restRequest/restRequest.dart';
import 'package:on_the_way_mobile/helpers/notifier.dart';
import 'package:on_the_way_mobile/screens/reset_password_screen2.dart';
import 'package:on_the_way_mobile/widgets/accent_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  static final String routeName = "/reset-password";
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _form = GlobalKey<FormState>();
  String emailAddress = "";
  Future<void> _saveForm() async {
    bool dataIsValid = _form.currentState.validate();
    if (dataIsValid) {
      _form.currentState.save();
      sendEmail();
      await showNotification(
          context,
          "Código enviado",
          "Hemos enviado un código de recuperación a su correo electrónico.",
          "Aceptar");
      _goToResetPassword2();
    }
  }

  Future<void> sendEmail() async {
    RestRequest restRequest = new RestRequest();
    Map<String, String> emailAddressRequest = {"emailAddress": emailAddress};
    await restRequest.putResource(
        "/v1/users/recoveryCode", emailAddressRequest, true);
  }

  void _goToResetPassword2() {
    // Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context)
        .pushNamed(ResetPasswordScreen2.routeName, arguments: emailAddress);
  }

  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
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
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: deviceWidth,
                              child: Text(
                                "Recuperar contraseña",
                                style: Theme.of(context).textTheme.headline1,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Ingresa tu correo electrónico",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Form(
                            key: _form,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelText: "Correo electrónico"),
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
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          AccentButton(
                              () => _saveForm(), "Recuperar contraseña"),
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
