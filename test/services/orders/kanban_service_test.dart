import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:partsflow/services/orders/kanban_service.dart';
import 'package:partsflow/data/models/order/requests/order_requests.dart';
import 'package:partsflow/core/globals/globals.dart';
import 'package:partsflow/core/widgets/sort_tag_filter.dart';

class MockClient extends Mock implements http.Client {}

class FakeListOrders extends Fake implements ListOrders {
  final Map<String, dynamic> _map = {};
  FakeListOrders([Map<String, dynamic>? initial]) {
    if (initial != null) _map.addAll(initial);
  }

  @override
  Map<String, dynamic> toMap() => _map;
}

void main() {
  late MockClient client;

  setUp(() {
    dotenv.testLoad(fileInput: "PARTSFLOW_API_URL=https://api.example.com");
    client = MockClient();
    registerFallbackValue(Uri());
    Globals.userToken = 'fake_token';
  });

  group('KanbanService', () {
    final validOrderJson = {
      'id': 1,
      'name': 'Order #1',
      'source': 'whatsapp',
      'operation_mode': 'manual',
      'prev_status': 'request',
      'status': 'identifying_car',
      'next_status': 'identifying_products',
      'estimated_category': 'Category A',
      'estimated_ticket': 1000,
      'car_identification_status': 'searching_plate_information',
      'product_identification_status': 'verifying_products',
      'product_requested_count': 5,
      'product_identified_count': 3,
      'oem_search_status': 'searching_oems',
      'stock_search_status': 'searching_stock',
      'cancel_reason': null,
      'is_proposal_sent': false,
      'is_quotations_link_opened': false,
      'is_ai_mark_as_purchase': false,
      'ai_mark_as_purchase_at': null,
      'subsidiary': 'Subsidiary A',
      'client': {
        'id': 'c1',
        'full_name': 'Client X',
        'profile_picture_url': 'http://example.com/pic.jpg',
        'phone': '123',
        'is_new': false,
        'is_recent': false,
        'chat_id': 'chat1',
        'is_last_message_inbound': false,
        'is_ai_active': false,
        'unread_message_count': 0,
        'last_message': 'hello',
        'last_message_at': '2023-01-01T10:00:00Z',
      },
      'client_car': {
        'id': 123,
        'plate': 'AA1234',
        'car': {
          'id': 1,
          'brand': {'id': 1, 'name': 'Toyota'},
          'model': 'X',
          'year': 2020,
        },
        'country': 'CL',
        'created_at': '2023-01-01T00:00:00Z',
        'updated_at': '2023-01-01T00:00:00Z',
      },
      'responsible': {'id': 'r1', 'first_name': 'Agent', 'email': 'a@a.com'},
      'accepted_at': '2023-01-01T10:00:00',
      'quotations_expiration_date': '2023-01-05T10:00:00',
      'internal_sale_number': 'SALE-001',
      'ticket': 1500,
      'quotation_substate': 'technical_doubt',
      'quotation_substate_change_date': null,
      'is_quotation_substate_identified_by_agent': false,
      'payment_method': 'webpay',
      'is_payment_identified_by_agent': true,
      'payment_date': '2023-01-02',
      'payment_verified': true,
      'payment_verified_by_method': 'manual',
      'payment_verified_by': 'Admin',
      'payment_verified_date': '2023-01-03',
      'delivery_method': 'local_withdrawal',
      'tentative_withdrawal_date': '2023-01-04',
      'effective_withdrawal_date': null,
      'is_withdrawal_person_client': true,
      'tentative_shipping_date': null,
      'courier': null,
      'shipping_tracking_number': null,
      'created_at': '2023-01-01T09:00:00',
      'updated_at': '2023-01-01T09:00:00',
      'opqs': [],
    };

    final resultsJson = {
      'results': [validOrderJson],
    };

    // Test 1: getKanbanOrders success
    test('getKanbanOrders returns List<KanbanOrderModel>', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(jsonEncode(resultsJson), 200));

      final results = await KanbanService.getKanbanOrders(
        FakeListOrders(),
        client: client,
      );
      expect(results.length, 1);
      expect(results.first.id, 1);
    });

    // Test 2: getKanbanOrders failure (500)
    test('getKanbanOrders throws HttpException on failure', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('Server Error', 500));

      expect(
        () => KanbanService.getKanbanOrders(FakeListOrders(), client: client),
        throwsA(isA<HttpException>()),
      );
    });

    // Test 3: Query Params Construction - Simple
    test('Constructs query params correctly (simple)', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(jsonEncode(resultsJson), 200));

      await KanbanService.getKanbanOrders(
        FakeListOrders({'page': 2, 'q': 'search'}),
        client: client,
      );

      verify(
        () => client.get(
          any(
            that: predicate<Uri>(
              (uri) =>
                  uri.queryParameters['page'] == '2' &&
                  uri.queryParameters['q'] == 'search',
            ),
          ),
          headers: any(named: 'headers'),
        ),
      ).called(1);
    });

    // Test 4: Query Params - List
    test('Constructs query params correctly (list)', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(jsonEncode(resultsJson), 200));

      await KanbanService.getKanbanOrders(
        FakeListOrders({
          'ids': [1, 2, 3],
        }),
        client: client,
      );

      verify(
        () => client.get(
          any(
            that: predicate<Uri>(
              (uri) => uri.queryParameters['ids'] == '1,2,3',
            ),
          ),
          headers: any(named: 'headers'),
        ),
      ).called(1);
    });

    // Test 5: Query Params - SortTagSortingType (descendant category)
    test('Constructs sort query params correctly (desc category)', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(jsonEncode(resultsJson), 200));

      await KanbanService.getKanbanOrders(
        FakeListOrders({'sort_by_category': SortTagSortingType.descendant}),
        client: client,
      );

      verify(
        () => client.get(
          any(
            that: predicate<Uri>(
              (uri) =>
                  uri.queryParameters['sort_by_category'] == '-category_weight',
            ),
          ),
          headers: any(named: 'headers'),
        ),
      ).called(1);
    });

    // Test 6: Query Params - SortTagSortingType (ascendant ticket)
    test('Constructs sort query params correctly (asc ticket)', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(jsonEncode(resultsJson), 200));

      await KanbanService.getKanbanOrders(
        FakeListOrders({
          'sort_by_estimated_ticket': SortTagSortingType.ascendant,
        }),
        client: client,
      );

      verify(
        () => client.get(
          any(
            that: predicate<Uri>(
              (uri) =>
                  uri.queryParameters['sort_by_estimated_ticket'] ==
                  'estimated_ticket',
            ),
          ),
          headers: any(named: 'headers'),
        ),
      ).called(1);
    });

    // Test 7: Query Params - SortTagSortingType (default created_at)
    test('Constructs sort query params correctly (default)', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(jsonEncode(resultsJson), 200));

      await KanbanService.getKanbanOrders(
        FakeListOrders({'sort_by_date': SortTagSortingType.descendant}),
        client: client,
      );

      verify(
        () => client.get(
          any(
            that: predicate<Uri>(
              (uri) => uri.queryParameters['sort_by_date'] == '-created_at',
            ),
          ),
          headers: any(named: 'headers'),
        ),
      ).called(1);
    });

    // Test 8: Missing results key in response
    test('Handle response without results key (throws)', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('{}', 200));

      expect(
        () => KanbanService.getKanbanOrders(FakeListOrders(), client: client),
        throwsA(anything),
      );
    });

    // Test 9: Null query params are ignored
    test('Null query params are skipped', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(jsonEncode(resultsJson), 200));

      await KanbanService.getKanbanOrders(
        FakeListOrders({'page': null}),
        client: client,
      );

      verify(
        () => client.get(
          any(
            that: predicate<Uri>(
              (uri) => !uri.queryParameters.containsKey('page'),
            ),
          ),
          headers: any(named: 'headers'),
        ),
      ).called(1);
    });

    // Test 10: Exception propagation
    test('Propagates client exceptions', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenThrow(Exception('Fail'));

      expect(
        () => KanbanService.getKanbanOrders(FakeListOrders(), client: client),
        throwsA(isA<Exception>()),
      );
    });
  });
}
