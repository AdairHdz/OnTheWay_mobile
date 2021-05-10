import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:on_the_way_mobile/screens/reset_password_screen.dart';
import 'package:on_the_way_mobile/screens/reset_password_screen2.dart';
import 'package:on_the_way_mobile/screens/reset_password_screen3.dart';

void main() {

  testWidgets("Given an invalid email, error message should appear",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ResetPasswordScreen(),
      ),
    );

    final buttonFinder = find.text("Recuperar contraseña");
    final userErrorFinder = find.text("Dirección de correo inválida");
    await tester.tap(buttonFinder);
    print("Button tapped");
    await tester.pump(const Duration(milliseconds: 100));
    expect(userErrorFinder, findsOneWidget);
    print("Validated email inline error");
  });


  testWidgets("Given an invalid code, error message should appear",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ResetPasswordScreen2(),
      ),
    );

    final buttonFinder = find.text("Confirmar");
    final userErrorFinder = find.text("Código de verificación invalido");
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
        home: ResetPasswordScreen2(),
      ),
    );

    final buttonFinder = find.text("Restablecer contraseña");
    final userErrorFinder = find.text("Contraseña inválida");
    await tester.tap(buttonFinder);
    print("Button tapped");
    await tester.pump(const Duration(milliseconds: 100));
    expect(userErrorFinder, findsOneWidget);
    print("Validated email inline error");
  });
}
