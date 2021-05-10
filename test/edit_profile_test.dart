import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:on_the_way_mobile/screens/edit_profile_screen.dart';

void main() {
  testWidgets("Given an invalid name, error message should appear",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EditProfileScreen(),
      ),
    );

    final buttonFinder = find.text("Aceptar");
    final userErrorFinder =
        find.text("Por favor inserte solo letras y espacios en blanco");
    await tester.tap(buttonFinder);
    print("Button tapped");
    await tester.pump(const Duration(milliseconds: 100));
    expect(userErrorFinder, findsOneWidget);
    print("Validated name inline error");
  });

  testWidgets("Given an invalid last name, error message should appear",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EditProfileScreen(),
      ),
    );

    final buttonFinder = find.text("Aceptar");
    final userErrorFinder =
        find.text("Por favor inserte solo letras y espacios en blanco");
    await tester.tap(buttonFinder);
    print("Button tapped");
    await tester.pump(const Duration(milliseconds: 100));
    expect(userErrorFinder, findsOneWidget);
    print("Validated last name inline error");
  });

  testWidgets("Given an invalid email, error message should appear",
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EditProfileScreen(),
      ),
    );

    final buttonFinder = find.text("Aceptar");
    final userErrorFinder = find.text("Dirección de correo inválida");
    await tester.tap(buttonFinder);
    print("Button tapped");
    await tester.pump(const Duration(milliseconds: 100));
    expect(userErrorFinder, findsOneWidget);
    print("Validated email inline error");
  });
}
