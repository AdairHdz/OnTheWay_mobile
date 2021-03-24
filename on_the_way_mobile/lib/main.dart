import 'package:flutter/material.dart';
import "./screens/services_screen.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(22, 110, 229, 1),
        primaryColorDark: Color.fromRGBO(10, 47, 89, 1),
        accentColor: Color.fromRGBO(243, 139, 25, 1),
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black87,
          ),
        ),
      ),
      home: ServicesScreen(),
      routes: {
        "/services": (ctx) => ServicesScreen(),
      },
    );
  }
}
