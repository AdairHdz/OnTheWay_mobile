import "package:flutter/material.dart";
import "../widgets/accent_button.dart";
import "./reset_password_screen2.dart";
import "./login_screen.dart";

class ResetPasswordScreen3 extends StatefulWidget {
  static final String routeName = "/reset-password3";
  @override
  _ResetPasswordScreenState3 createState() => _ResetPasswordScreenState3();
}

class _ResetPasswordScreenState3 extends State<ResetPasswordScreen3> {
  final _form = GlobalKey<FormState>();

  void _saveForm() {
    bool dataIsValid = _form.currentState.validate();
    print(dataIsValid);
    if (dataIsValid) {
      _form.currentState.save();
      _goToLogin();
    }
  }

  void _goToLogin() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text("Las contraseñas no coinciden"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                    "Por favor ingrese la misma contraseña con al menos 8 caracteres"),
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

  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    String password = "";
    String confirmationPassword = "";
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
                            "Restablecer contraseña",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Ingresa la nueva contraseña",
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
                                  decoration:
                                      InputDecoration(labelText: "Contraseña"),
                                  onSaved: (value) {
                                    print(value);
                                  },
                                  validator: (value) {
                                    password = value.trim();
                                    if (password.length >= 8 &&
                                        password.length <= 50) {
                                      return null;
                                    }
                                    return "Contraseña inválida";
                                  },
                                  obscureText: true,
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "Con firmar contraseña"),
                                  onSaved: (value) {
                                    print(value);
                                  },
                                  validator: (value) {
                                    confirmationPassword = value.trim();
                                    if (confirmationPassword.length >= 8 &&
                                        confirmationPassword.length <= 50 &&
                                        (password == confirmationPassword)) {
                                      return null;
                                    }else{
                                      _showMyDialog(context);
                                    }
                                    return "Contraseña inválida";
                                  },
                                  obscureText: true,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          AccentButton(
                              () => _saveForm(), "Restablecer contraseña"),
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
