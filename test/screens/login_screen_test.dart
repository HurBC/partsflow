import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:partsflow/screens/login/login_screen.dart';
import 'package:partsflow/services/user_service.dart';
import 'package:partsflow/core/colors/partsflow_colors.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient client;

  setUp(() {
    dotenv.testLoad(fileInput: "PARTSFLOW_API_URL=https://api.example.com");
    client = MockClient();
    registerFallbackValue(Uri());
    AuthService.mockClient = client;
  });

  tearDown(() {
    AuthService.mockClient = null;
  });

  Future<void> pumpLoginScreen(WidgetTester tester) async {
    // We need GoRouter because LoginScreen uses context.go
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
        GoRoute(
          path: '/orders/kanban',
          builder: (context, state) =>
              const Scaffold(body: Text('Kanban Screen')),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
  }

  group('LoginScreen', () {
    // Test 1: Renders correctly
    testWidgets('renders login screen elements', (tester) async {
      await pumpLoginScreen(tester);

      expect(find.text('Login in Partsflow'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2)); // Email and Password
      expect(
        find.text('Ingrersar'),
        findsOneWidget,
      ); // Typo in source code verified
    });

    // Test 2: Shows error if email empty
    testWidgets('shows error if email is empty', (tester) async {
      await pumpLoginScreen(tester);

      await tester.tap(find.text('Ingrersar'));
      await tester.pump(); // frame

      expect(find.text('El correo es necesario'), findsOneWidget);
    });

    // Test 3: Shows error if password empty
    testWidgets('shows error if password is empty', (tester) async {
      await pumpLoginScreen(tester);

      await tester.enterText(
        find.byType(TextField).first,
        'fcobreque1204@gmail.com',
      );
      await tester.tap(find.text('Ingrersar'));
      await tester.pump();

      expect(find.text('La contraseña es necesaria'), findsOneWidget);
    });

    // Test 4: Toggles password visibility
    testWidgets('toggles password visibility', (tester) async {
      await pumpLoginScreen(tester);

      final passwordFieldQuery = find.byType(TextField).last;
      TextField passwordField = tester.widget(passwordFieldQuery);
      expect(passwordField.obscureText, true); // initially obscured

      // Tap visibility icon (suffix)
      await tester.tap(
        find.byIcon(Icons.visibility),
      ); // Assuming initial is visibility
      await tester.pump();

      passwordField = tester.widget(passwordFieldQuery);
      expect(passwordField.obscureText, false); // now visible

      // Tap again
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      passwordField = tester.widget(passwordFieldQuery);
      expect(passwordField.obscureText, true);
    });

    // Test 5: Successful login navigation
    testWidgets('navigates to kanban on success', (tester) async {
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          jsonEncode({'token': 't', 'access_token': 'a', 'refresh_token': 'r'}),
          200,
        ),
      );

      await pumpLoginScreen(tester);

      await tester.enterText(
        find.byType(TextField).first,
        'fcobreque1204@gmail.com',
      );
      await tester.enterText(find.byType(TextField).last, 'password');
      await tester.tap(find.text('Ingrersar'));

      // Settle animations (navigation)
      await tester.pumpAndSettle();

      expect(find.text('Kanban Screen'), findsOneWidget);
      expect(find.text('Inicio de sesion exitoso'), findsOneWidget);
    });

    // Test 6: Network Error (HttpException)
    testWidgets('shows error snackbar on login failure', (tester) async {
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => http.Response('Invalid credentials', 400));

      await pumpLoginScreen(tester);

      await tester.enterText(
        find.byType(TextField).first,
        'fcobreque1204@gmail.com',
      );
      await tester.enterText(find.byType(TextField).last, 'password');
      await tester.tap(find.text('Ingrersar'));

      await tester.pumpAndSettle(); // Wait for async call and snackbar anim

      // The snackbar shows error message
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      // Error message construction in AuthService throws HttpException with body as message?
      // user_service logic: throw HttpException("Error ... code: 400")
      expect(find.textContaining('Error al iniciar sesion'), findsOneWidget);
    });

    // Test 7: Loading State
    testWidgets('shows loading text while logging in', (tester) async {
      // Delay the response
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 1));
        return http.Response(
          jsonEncode({'token': 't', 'access_token': 'a', 'refresh_token': 'r'}),
          200,
        );
      });

      await pumpLoginScreen(tester);

      await tester.enterText(find.byType(TextField).first, 'a');
      await tester.enterText(find.byType(TextField).last, 'b');
      await tester.tap(find.text('Ingrersar'));
      await tester.pump(); // Start frame

      expect(find.text('Ingresando...'), findsOneWidget);

      await tester.pump(const Duration(seconds: 1)); // Advance time
      await tester.pumpAndSettle();
    });

    // Test 8: Verify API call parameters
    testWidgets('calls login with correct parameters', (tester) async {
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          jsonEncode({'token': 't', 'access_token': 'a', 'refresh_token': 'r'}),
          200,
        ),
      );

      await pumpLoginScreen(tester);
      await tester.enterText(find.byType(TextField).first, 'user@test.com');
      await tester.enterText(find.byType(TextField).last, 'pass123');
      await tester.tap(find.text('Ingrersar'));
      await tester.pumpAndSettle();

      verify(
        () => client.post(
          any(),
          body: jsonEncode({"email": "user@test.com", "password": "pass123"}),
          headers: any(named: 'headers'),
        ),
      ).called(1);
    });

    // Test 9: Renders background color
    testWidgets('renders functionality colors', (tester) async {
      await pumpLoginScreen(tester);
      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold).first);
      expect(scaffold.backgroundColor, PartsflowColors.primary);
    });

    // Test 10: Renders inputs with white text style
    testWidgets('inputs have white text style', (tester) async {
      await pumpLoginScreen(tester);
      final textField = tester.widget<TextField>(find.byType(TextField).first);
      expect(textField.style?.color, Colors.white);
    });
  });
}
