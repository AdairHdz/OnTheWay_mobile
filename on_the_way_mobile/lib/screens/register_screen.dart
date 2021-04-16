import "package:flutter/material.dart";
import "../widgets/accent_button.dart";

class RegisterScreen extends StatefulWidget {
  static final String routeName = "/register";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
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
                                  onSaved: (value) {
                                    print(value);
                                  },
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "Apellidos"),
                                  onSaved: (value) {
                                    print(value);
                                  },
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "Correo"),
                                  onSaved: (value) {
                                    print(value);
                                  },
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "Contraseña"),
                                  onSaved: (value) {
                                    print(value);
                                  },
                                  obscureText: true,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Confirmar contraseña"),
                                  onSaved: (value) {
                                    print(value);
                                  },
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
                          AccentButton(() {}, "Iniciar sesión"),
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
                top: 0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
