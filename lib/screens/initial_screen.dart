import "package:flutter/material.dart";
import 'package:on_the_way_mobile/screens/login_screen.dart';
import 'package:on_the_way_mobile/screens/register_screen.dart';
import 'package:on_the_way_mobile/widgets/rounded_button.dart';

class InitialScreen extends StatelessWidget {
  static final String routeName = "/initial";
  void navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).pushNamed(LoginScreen.routeName);
  }

  void navigateToRegisterScreen(BuildContext context) {
    Navigator.of(context).pushNamed(RegisterScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Image(
                image: AssetImage(
                  "assets/images/logo.png",
                ),
                width: 150,
              ),
            ),
            Container(
              width: (deviceWidth * 0.7),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: RoundedButton("Iniciar sesión",
                              () => navigateToLoginScreen(context)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: RoundedButton("Registrarme",
                              () => navigateToRegisterScreen(context)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
