import "package:flutter/material.dart";
import 'package:on_the_way_mobile/screens/home_screen_sr.dart';
import "../widgets/accent_button.dart";
import "./home_screen.dart";

class LoginScreen extends StatefulWidget {
  static final String routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();

  void _saveForm() {
    bool dataIsValid = _form.currentState.validate();
    if (dataIsValid) {
      _goToHomeScreen(context);
      _form.currentState.save();
    }
  }

  void _goToHomeScreen(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacementNamed(HomeScreenSr.routeName);
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
                                    print(value);
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "Contraseña"),
                                  obscureText: true,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextButton(
                            child: Text("¿Olvidaste tu contraseña?"),
                            onPressed: () {},
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
