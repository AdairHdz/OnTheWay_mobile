import 'package:flutter/material.dart';
import 'package:on_the_way_mobile/models/service.dart';
import 'package:on_the_way_mobile/screens/tabs_screen.dart';
import "./screens/services_screen.dart";
import 'screens/initial_screen.dart';
import 'screens/login_screen.dart';
import 'screens/price_rate_registration_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/accept_cancel_service.dart';
import 'screens/statistics_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/reset_password_screen.dart';
import 'screens/reset_password_screen2.dart';
import 'screens/reset_password_screen3.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(22, 110, 229, 1),
        primaryColorDark: Color.fromRGBO(10, 47, 89, 1),
        accentColor: Color.fromRGBO(243, 139, 25, 1),
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 40,
            color: Colors.black87,
          ),
        ),
      ),
      home: InitialScreen(),
      routes: {
        "/initial": (ctx) => InitialScreen(),
        "/login": (ctx) => LoginScreen(),
        "/register": (ctx) => RegisterScreen(),
        "/services": (ctx) => ServicesScreen(),
        "/home": (ctx) => TabsScreen(),
        "/price-rate": (ctx) => PriceRateRegistrationScreen(),
        "/accept_cancel_service": (ctx) => AcceptCancelService(),
        "/statistics": (ctx) => StatisticsScreen(),
        "/edit-profile": (ctx) => EditProfileScreen(),
        "/reset-password": (ctx) => ResetPasswordScreen(),
        "/reset-password2": (ctx) => ResetPasswordScreen2(),
        "/reset-password3": (ctx) => ResetPasswordScreen3(),
      },
    );
  }
}
