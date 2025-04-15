// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myapp/main.dart';

void main() {
  testWidgets('Login Page UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that the title is displayed.
    expect(find.text('Sistema de Checklist'), findsOneWidget);

    // Verify that the subtitle is displayed.
    expect(find.text('Faça login para acessar o sistema'), findsOneWidget);

    // Verify that the username text field is present.
    expect(find.widgetWithText(TextField, 'Usuário'), findsOneWidget);

    // Verify that the password text field is present.
    expect(find.widgetWithText(TextField, 'Senha'), findsOneWidget);

    // Verify that the login button is present.
    expect(find.widgetWithText(ElevatedButton, 'Entrar'), findsOneWidget);
  });
}
