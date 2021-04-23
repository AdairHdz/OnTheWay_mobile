import "package:flutter/material.dart";
import "../widgets/accent_button.dart";

class RegisterScreen extends StatefulWidget {
  static final String routeName = "/register";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();

  void _saveForm() {
    bool dataIsValid = _form.currentState.validate();
    print(dataIsValid);
    if (dataIsValid) {
      _form.currentState.save();
    }
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text("Contraseña insegura"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                    "Por favor inserte una contraseña con al menos 8 caracteres"),
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
                                      print("Valida");
                                      return null;
                                    }
                                    print("Invalida");
                                    return "Por favor inserte solo letras y espacios en blanco";
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
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "Contraseña"),
                                  onSaved: (value) {
                                    print(value);
                                  },
                                  validator: (value) {
                                    String password = value.trim();
                                    if (password.length >= 8 &&
                                        password.length <= 50) {
                                      return null;
                                    }
                                    _showMyDialog(context);
                                    return "Contraseña inválida";
                                  },
                                  obscureText: true,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Confirmar contraseña"),
                                  obscureText: true,
                                ),
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
