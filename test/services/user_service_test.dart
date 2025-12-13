import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:partsflow/services/user_service.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient client;

  setUp(() {
    client = MockClient();
    registerFallbackValue(Uri());
  });

  group('AuthService', () {
    test('login returns LoginResponse on success (200)', () async {
      final responseBody = {
        "token": "fake_token",
        "access_token": "fake_access_token",
        "refresh_token": "fake_refresh_token",
      };

      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseBody), 200));

      final result = await AuthService.login(
        email: 'test@example.com',
        password: 'password',
        client: client,
      );

      expect(result, isNotNull);
      expect(result?.token, 'fake_token');
    });

    test('login throws HttpException on failure', () async {
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 400));

      expect(
        AuthService.login(
          email: 'test@example.com',
          password: 'password',
          client: client,
        ),
        throwsA(isA<HttpException>()),
      );
    });
  });
}
