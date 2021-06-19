import 'package:flutter/material.dart';
import 'package:on_the_way_mobile/screens/accept_cancel_service.dart';
import 'package:on_the_way_mobile/screens/activation_account_screen.dart';
import 'package:on_the_way_mobile/screens/edit_profile_screen.dart';
import 'package:on_the_way_mobile/screens/home_screen_sr.dart';
import 'package:on_the_way_mobile/screens/initial_screen.dart';
import 'package:on_the_way_mobile/screens/login_screen.dart';
import 'package:on_the_way_mobile/screens/price_rate_registration_screen.dart';
import 'package:on_the_way_mobile/screens/register_screen.dart';
import 'package:on_the_way_mobile/screens/request_service.dart';
import 'package:on_the_way_mobile/screens/reset_password_screen.dart';
import 'package:on_the_way_mobile/screens/reset_password_screen2.dart';
import 'package:on_the_way_mobile/screens/reset_password_screen3.dart';
import 'package:on_the_way_mobile/screens/services_screen.dart';
import 'package:on_the_way_mobile/screens/statistics_screen.dart';
import 'package:on_the_way_mobile/screens/tabs_screen.dart';
import 'package:on_the_way_mobile/screens/service_providers_list_screen.dart';

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
        "/homesr": (ctx) => HomeScreenSr(),
        "/request_service": (ctx) => RequestService(),
        "/edit-profile": (ctx) => EditProfileScreen(),
        "/reset-password": (ctx) => ResetPasswordScreen(),
        "/reset-password2": (ctx) => ResetPasswordScreen2(),
        "/reset-password3": (ctx) => ResetPasswordScreen3(),
        "/activation-account": (ctx) => ActivationAccountScreen(),

        
        "/service-providers-list": (ctx) => ServiceProviderListScreen(),
      },
    );
  }
}
