import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:partsflow/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:partsflow/core/globals/globals.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient client;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    dotenv.testLoad(fileInput: "PARTSFLOW_API_URL=https://api.example.com");
    client = MockClient();
    registerFallbackValue(Uri());
  });

  tearDown(() {
    Globals.userToken = null; // Reset token
  });

  group('AuthService', () {
    const email = 'fcobreque1204@gmail.com';
    const password = 'Faco1214';

    final successBody = {
      'token': 'test_token',
      'access_token': 'access',
      'refresh_token': 'refresh',
    };

    // Test 1: Successful login
    test('login returns LoginResponse on success (200)', () async {
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(successBody), 200));

      final result = await AuthService.login(
        email: email,
        password: password,
        client: client,
      );

      expect(result, isNotNull);
      expect(result?.token, 'test_token');
      expect(Globals.userToken, 'test_token');
    });

    // Test 2: Invalid Credentials (400)
    test('login throws HttpException on failure (400)', () async {
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => http.Response('Invalid credentials', 400));

      expect(
        () =>
            AuthService.login(email: email, password: password, client: client),
        throwsA(isA<HttpException>()),
      );
    });

    // Test 3: Unauthorized (401)
    test('login throws HttpException on unauthorized (401)', () async {
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => http.Response('Unauthorized', 401));

      expect(
        () =>
            AuthService.login(email: email, password: password, client: client),
        throwsA(isA<HttpException>()),
      );
    });

    // Test 4: Server Error (500)
    test('login throws HttpException on server error (500)', () async {
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => http.Response('Server error', 500));

      expect(
        () =>
            AuthService.login(email: email, password: password, client: client),
        throwsA(isA<HttpException>()),
      );
    });

    // Test 5: Verify URL and Headers
    test('login calls correct URL with correct headers', () async {
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(successBody), 200));

      await AuthService.login(email: email, password: password, client: client);

      verify(
        () => client.post(
          Uri.parse(
            "https://api.example.com/users/login/",
          ), // Assuming Env defaults
          // Or strictly match capture
          body: jsonEncode({"email": email, "password": password}),
          headers: {
            "accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      ).called(1);
    });

    // Test 6: Malformed response body (not json) - should throw FormatException
    test('login throws FormatException if response is not json', () async {
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => http.Response('Internal Proxy Error', 200));
      // Status 200 but body not JSON (e.g. HTML or text)

      expect(
        () =>
            AuthService.login(email: email, password: password, client: client),
        throwsA(isA<FormatException>()),
      );
    });

    // Test 7: Missing token in response (Parsing error?)
    test('login throws validation error if token missing', () async {
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(jsonEncode({'other': 'value'}), 200),
      );

      // LoginResponse.fromJson might throw or return nulls depending on implementation.
      // Checking LoginResponse: factory throws error if 'token' is missing typically unless nullable?
      // "token: json["token"]" -> if json["token"] is null and token is String, it throws.
      expect(
        () =>
            AuthService.login(email: email, password: password, client: client),
        throwsA(anything),
      );
    });

    // Test 8: Empty email/password handling (Client side logic?)
    // The service doesn't validate, just sends. But let's verify it sends empties.
    test('login sends empty credentials if provided', () async {
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(successBody), 200));

      await AuthService.login(email: '', password: '', client: client);

      verify(
        () => client.post(
          any(),
          body: jsonEncode({"email": "", "password": ""}),
          headers: any(named: 'headers'),
        ),
      ).called(1);
    });

    // Test 9: Exception during HTTP call (e.g. SocketException)
    // We can't easily mock SocketException with MockClient generally unless we throw it.
    test('login propagates exceptions from client', () async {
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenThrow(Exception('Connection failed'));

      expect(
        () =>
            AuthService.login(email: email, password: password, client: client),
        throwsA(isA<Exception>()),
      );
    });

    // Test 10: Timeout (Simulated limitation of manual mock or just verify configuration)
    // Testing timeout logic is hard with MockClient as it returns instantly.
    // We can just verify the method call happened.
    // However, if we delay the answer?
    test('Client is called once', () async {
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(successBody), 200));

      await AuthService.login(email: email, password: password, client: client);
      verify(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).called(1);
    });
  });
}
