import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:partsflow/services/orders/orders_service.dart';

import 'package:partsflow/data/requests/orders/create_order.dart';
import 'package:partsflow/data/requests/orders/update_draft_order.dart';
import 'package:partsflow/core/globals/globals.dart';

class MockClient extends Mock implements http.Client {}

class FakeCreateOrder extends Fake implements CreateOrder {
  @override
  Map<String, dynamic> toJson() => {'fake': 'data'};
}

class FakeUpdateDraftOrder extends Fake implements UpdateDraftOrder {
  @override
  int get id => 123;
  @override
  Map<String, dynamic> toJson() => {'fake': 'update'};
}

void main() {
  late MockClient client;

  setUp(() {
    dotenv.testLoad(fileInput: "PARTSFLOW_API_URL=https://api.example.com");
    client = MockClient();
    registerFallbackValue(Uri());
    Globals.userToken = 'fake_token';
  });

  group('OrdersService', () {
    const orderId = 1;

    final validOrderModelJson = {
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
      'client': "e6730a02-8763-44d1-b0d1-db87835fbd87",
      'client_car': 123,
      'responsible': "r1",
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
    };

    final validOrderDetailJson = {
      ...validOrderModelJson,
      'client': {
        'id': 'c1',
        'full_name': 'Client X',
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
        'is_agent_pending_resolution': false,
        'created_at': '2023-01-01T00:00:00Z',
        'updated_at': '2023-01-01T00:00:00Z',
      },
      'responsible': {'id': 'r1', 'first_name': 'Agent'},
    };

    // Test 1: getOrder success
    test('getOrder returns OrderDetailRespository on success', () async {
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(
        (_) async => http.Response(jsonEncode(validOrderDetailJson), 200),
      );

      final result = await OrdersService.getOrder(
        orderId: orderId,
        client: client,
      );

      expect(result.id, orderId);
      verify(() => client.get(any(), headers: any(named: 'headers'))).called(1);
    });

    // Test 2: getOrder failure (404)
    test('getOrder throws HttpException on failure', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(
        () => OrdersService.getOrder(orderId: orderId, client: client),
        throwsA(isA<HttpException>()),
      );
    });

    // Test 3: createOrder success
    test('createOrder returns OrderModel on success (201)', () async {
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (_) async => http.Response(jsonEncode(validOrderModelJson), 201),
      );

      final result = await OrdersService.createOrder(
        FakeCreateOrder(),
        client: client,
      );

      expect(result.id, orderId);
    });

    // Test 4: createOrder failure
    test('createOrder throws HttpException on failure', () async {
      when(
        () => client.post(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 400));

      expect(
        () => OrdersService.createOrder(FakeCreateOrder(), client: client),
        throwsA(isA<HttpException>()),
      );
    });

    // Test 5: updateDraftOrder success
    test('updateDraftOrder returns true on success (200)', () async {
      when(
        () => client.patch(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => http.Response('{"status":"ok"}', 200));

      final result = await OrdersService.updateDraftOrder(
        FakeUpdateDraftOrder(),
        client: client,
      );

      expect(result, true);
    });

    // Test 6: updateDraftOrder failure
    test('updateDraftOrder throws HttpException on failure', () async {
      when(
        () => client.patch(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 500));

      expect(
        () => OrdersService.updateDraftOrder(
          FakeUpdateDraftOrder(),
          client: client,
        ),
        throwsA(isA<HttpException>()),
      );
    });

    // Test 7: Verify headers contain token
    test('get headers contain token', () async {
      Globals.userToken = 'my_secret_token';
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(
        (_) async => http.Response(jsonEncode(validOrderDetailJson), 200),
      );

      await OrdersService.getOrder(orderId: 1, client: client);

      final capturedHeaders = verify(
        () => client.get(any(), headers: captureAny(named: 'headers')),
      ).captured.last;
      expect(capturedHeaders['Authorization'], 'Bearer my_secret_token');
    });

    // Test 8: Malformed JSON response in getOrder
    test('getOrder throws FormatException on malformed json', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('{bad_json', 200));

      expect(
        () => OrdersService.getOrder(orderId: 1, client: client),
        throwsA(isA<FormatException>()),
      );
    });

    // Test 9: Exception propagation
    test('Propagates client exceptions', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenThrow(Exception('Network error'));

      expect(
        () => OrdersService.getOrder(orderId: 1, client: client),
        throwsA(isA<Exception>()),
      );
    });

    // Test 10: URI construction for updateDraftOrder
    test('URIs are constructed correctly for updateDraft', () async {
      when(
        () => client.patch(
          any(),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).thenAnswer((_) async => http.Response('{}', 200));

      await OrdersService.updateDraftOrder(
        FakeUpdateDraftOrder(),
        client: client,
      );
      // ID is 123
      verify(
        () => client.patch(
          any(
            that: predicate<Uri>(
              (uri) => uri.path.contains('/orders/123/update_draft_order/'),
            ),
          ),
          body: any(named: 'body'),
          headers: any(named: 'headers'),
        ),
      ).called(1);
    });
  });
}
