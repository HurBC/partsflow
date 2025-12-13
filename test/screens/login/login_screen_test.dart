import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:partsflow/screens/login/login_screen.dart';

void main() {
  testWidgets('LoginScreen has email and password fields and a button', (
    WidgetTester tester,
  ) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Find email text field
    expect(find.byType(TextField).at(0), findsOneWidget);
    // Find password text field
    expect(find.byType(TextField).at(1), findsOneWidget);
    // Find button
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('Ingrersar'), findsOneWidget);
  });

  testWidgets('LoginScreen shows validation error on empty email', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Tap login button without entering anything
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // Rebuild for snackbar

    // Expect snackbar with error
    expect(find.text('El correo es necesario'), findsOneWidget);
  });

  testWidgets('LoginScreen shows validation error on empty password', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Enter email
    await tester.enterText(
      find.byType(TextField).at(0),
      'fcobreque1204@gmail.com',
    );

    // Tap login button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Expect snackbar with error
    expect(find.text('La contraseña es necesaria'), findsOneWidget);
  });
}
