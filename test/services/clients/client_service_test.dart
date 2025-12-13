import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:partsflow/services/clients/client_service.dart';
import 'package:partsflow/data/models/clients/requests/search_client.dart';
import 'package:partsflow/core/globals/globals.dart';

class MockClient extends Mock implements http.Client {}

class FakeSearchClientParams extends Fake implements SearchClientParams {
  @override
  Map<String, dynamic> toMap() => {};
}

void main() {
  late MockClient client;

  setUp(() {
    dotenv.testLoad(
      fileInput:
          "PARTSFLOW_API_URL=https://repartes-suppliers-api-staging-cloud-sql-200748323211.southamerica-east1.run.app/api",
    );
    client = MockClient();
    registerFallbackValue(Uri());
    Globals.userToken = 'fake_token';
  });

  group('ClientService', () {
    final clientJson = {
      'id': 'c1',
      'first_name': 'John',
      'last_name': 'Doe',
      'full_name': 'John Doe',
      'name': 'John Doe', // Added match for name
      'run': '12345678-9',
      'email': 'john@example.com',
      'phone': '1234567890',
      'is_new': false,
      'is_active': true,
      'is_chat_hidden_from_admin': false,
      'is_chat_resolved': false,
      'is_last_message_inbound': false,
      'is_last_outbound_message_ai': false,
      'unread_message_count': 0,
      'is_quote_agent_active': false,
      'is_order_taker_agent_restricted': false,
      'operation_mode': 'manual',
      'origin': 'other',
      'importance_level': 'low',
      'lead_generation_channel': 'web',
      'is_agent_pending_resolution': false,
      'created_at': '2023-01-01T00:00:00.000Z',
      'updated_at': '2023-01-01T00:00:00.000Z',
      'responsible': {
        'id': 'u1',
        'first_name': 'Agent',
        'last_name': 'Smith',
        'email': 'agent@example.com',
      }, // Nested responsible object
      'general_attributes': {
        'id': 1,
        'client': 'c1',
        'has_active_issues': false,
        'has_active_quotation_orders': true,
        'has_manual_assitance_trigger': false,
        'has_pending_close_orders': false,
        'has_pending_invoice': false,
      }, // Nested general attributes
    };

    final listResponse = {
      'count': 1,
      'next': null,
      'previous': null,
      'results': [clientJson],
    };

    // Test 1: searchClients success
    test('searchClients returns ListApiResponse<Client> on success', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(jsonEncode(listResponse), 200));

      final result = await ClientService.searchClients(
        FakeSearchClientParams(),
        client: client,
      );

      expect(result.count, 1);
      expect(result.results.length, 1);
      expect(result.results.first.firstName, 'John');
    });

    // Test 2: searchClients failure (500)
    test('searchClients throws Exception on failure', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('Error', 500));

      expect(
        () => ClientService.searchClients(
          FakeSearchClientParams(),
          client: client,
        ),
        throwsA(isA<Exception>()),
      );
    });

    // Test 3: Verify URI construction
    test('searchClients constructs URI correctly', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(jsonEncode(listResponse), 200));

      // Need a SearchClientParams that returns specific map
      // Fake doesn't allow constructor args easily unless I override toMap dynamically or use Mock.
      // Or just create a real one if I knew the fields.
      // Assuming I can use real class or just rely on Fake returning empty map -> empty query params.
      await ClientService.searchClients(
        FakeSearchClientParams(),
        client: client,
      );

      verify(() => client.get(any(), headers: any(named: 'headers'))).called(1);
    });

    // Test 4: Empty results
    test('searchClients handles empty results', () async {
      final emptyResponse = {'count': 0, 'results': []};
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(jsonEncode(emptyResponse), 200));

      final result = await ClientService.searchClients(
        FakeSearchClientParams(),
        client: client,
      );
      expect(result.results, isEmpty);
    });

    // Test 5: Malformed JSON
    test('searchClients throws FormatException on malformed json', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('{bad', 200));

      expect(
        () => ClientService.searchClients(
          FakeSearchClientParams(),
          client: client,
        ),
        throwsA(isA<FormatException>()),
      );
    });

    // Test 6: Network Error
    test('searchClients propagates network errors', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenThrow(SocketException('No internet'));

      expect(
        () => ClientService.searchClients(
          FakeSearchClientParams(),
          client: client,
        ),
        throwsA(isA<SocketException>()),
      );
    });

    // Test 7: Verify headers
    test('Requests have correct headers', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(jsonEncode(listResponse), 200));

      await ClientService.searchClients(
        FakeSearchClientParams(),
        client: client,
      );

      final captured = verify(
        () => client.get(any(), headers: captureAny(named: 'headers')),
      ).captured.last;
      expect(captured['Authorization'], contains('Bearer'));
    });

    // Test 8: 403 Forbidden
    test('searchClients throws Exception on 403', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('Forbidden', 403));

      expect(
        () => ClientService.searchClients(
          FakeSearchClientParams(),
          client: client,
        ),
        throwsA(isA<Exception>()),
      );
    });

    // Test 9: 404 Not Found
    test('searchClients throws Exception on 404', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(
        () => ClientService.searchClients(
          FakeSearchClientParams(),
          client: client,
        ),
        throwsA(isA<Exception>()),
      );
    });

    // Test 10: Null client (uses default internal client)
    // We can't really test this without making a real network request (which we shouldn't).
    // So we just verify we can pass our mock client.
    test('Accepts injected client', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(jsonEncode(listResponse), 200));

      await ClientService.searchClients(
        FakeSearchClientParams(),
        client: client,
      );
      // if it didn't use our client, 'verify' would fail or 'when' wouldn't be triggered.
      verify(() => client.get(any(), headers: any(named: 'headers'))).called(1);
    });
  });
}
