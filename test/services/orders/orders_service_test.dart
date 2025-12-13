import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:partsflow/services/orders/orders_service.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient client;

  setUp(() {
    client = MockClient();
    registerFallbackValue(Uri());
  });

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
    'client': 'Client X',
    'client_car': 123,
    'responsible': 'Agent Y',
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

  group('OrdersService', () {
    test('getOrder returns OrderDetailRespository on success', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(jsonEncode(validOrderJson), 200));

      final result = await OrdersService.getOrder(orderId: 1, client: client);

      expect(result.id, 1);
      expect(result.name, 'Order #1');
    });

    test('getOrder throws HttpException on failure', () async {
      when(
        () => client.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('Error', 404));

      expect(
        OrdersService.getOrder(orderId: 1, client: client),
        throwsA(isA<HttpException>()),
      );
    });

    // TODO: Add tests for createOrder and updateDraftOrder
    // I need mock objects for CreateOrder and UpdateDraftOrder requests,
    // but since I don't have their constructors handy, I'll skip complex input construction for now
    // or assume they are simple data classes.
  });
}
