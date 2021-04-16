// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:on_the_way_mobile/screens/login_screen.dart';

void main() {
  testWidgets("Given an invalid email, error message should appear",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoginScreen(),
      ),
    );

    final buttonFinder = find.text("Iniciar sesión");
    final userErrorFinder = find.text("Dirección de correo inválida");
    await tester.tap(buttonFinder);
    print("Button tapped");
    await tester.pump(const Duration(milliseconds: 100));
    expect(userErrorFinder, findsOneWidget);
    print("Validated email inline error");
  });

  testWidgets("Given an invalid password, error message should appear",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoginScreen(),
      ),
    );

    final buttonFinder = find.text("Iniciar sesión");
    final userErrorFinder =
        find.text("Ingrese una contraseña de mínimo 8 caracteres");
    await tester.tap(buttonFinder);
    print("Button tapped");
    await tester.pump(const Duration(milliseconds: 100));
    expect(userErrorFinder, findsOneWidget);
    print("Validated password inline error");
  });
}
