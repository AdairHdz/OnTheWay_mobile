import "package:flutter/material.dart";
import "../widgets/accent_button.dart";
import "./reset_password_screen3.dart";
import "../widgets/accent_button.dart";

class ResetPasswordScreen2 extends StatefulWidget {
  static final String routeName = "/reset-password2";

  @override
  _ResetPasswordScreenState2 createState() => _ResetPasswordScreenState2();
}

class _ResetPasswordScreenState2 extends State<ResetPasswordScreen2> {
  final _form = GlobalKey<FormState>();

  void _saveForm() {
    bool dataIsValid = _form.currentState.validate();
    if (dataIsValid) {
      _form.currentState.save();
      _goToResetPassword3();
    }
  }

  void _goToResetPassword3() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacementNamed(ResetPasswordScreen3.routeName);
  }

  @override
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
                          Text(
                            "Recuperar contraseña",
                            style: Theme.of(context).textTheme.headline1,
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
                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelText: "Código de verificación"),
                              validator: (value) {
                                var isValidData = new RegExp(
                                        r"^([0-9]){8}$",
                                        caseSensitive: false)
                                    .hasMatch(value.trim());
                                if (isValidData) {
                                  return null;
                                }
                                return "Código de verificación invalido";
                              },
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
