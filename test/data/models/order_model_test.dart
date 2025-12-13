import 'package:flutter_test/flutter_test.dart';
import 'package:partsflow/data/models/order/order.dart';
import 'package:partsflow/data/models/order/enums/order_enums.dart';

void main() {
  group('OrderModel', () {
    final baseJson = {
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

    // Test 1: Valid fromJson
    test('fromJson creates a valid OrderModel', () {
      final order = OrderModel.fromJson(baseJson);

      expect(order.id, 1);
      expect(order.source, OrderSourceChoices.whatsapp);
      expect(order.operationMode, OrderOperationModeEnum.manual);
      expect(order.status, OrderStatusChoices.identifyingCar);
      expect(order.productRequestedCount, 5);
      expect(order.subsidiary, 'Subsidiary A');
    });

    // Test 2: Enum Parsing
    test('Enums are parsed correctly', () {
      final json = Map<String, dynamic>.from(baseJson);
      json['status'] = 'order_quoted';
      final order = OrderModel.fromJson(json);
      expect(order.status, OrderStatusChoices.orderQuoted);
    });

    // Test 3: Null Enums (optional ones)
    test('Optional enums can be null', () {
      final json = Map<String, dynamic>.from(baseJson);
      json['prev_status'] = null;
      json['cancel_reason'] = null;
      final order = OrderModel.fromJson(json);
      expect(order.prevStatus, null);
      expect(order.cancelReason, null);
    });

    // Test 4: Required fields missing throws error
    test('Missing required field throws', () {
      final json = Map<String, dynamic>.from(baseJson);
      json.remove('id');
      expect(() => OrderModel.fromJson(json), throwsA(anything));
    });

    // Test 5: KanbanOrderModel fromJson (minimal)
    test('KanbanOrderModel fromJson minimal', () {
      final json = Map<String, dynamic>.from(baseJson);
      json['opqs'] = [];
      // KanbanOrderModel expects 'opqs' list

      final order = KanbanOrderModel.fromJson(json);
      expect(order.id, 1);
      expect(order.opqs, isEmpty);
    });

    // Test 6: KanbanOrderModel with structured client/responsible
    test('KanbanOrderModel parses client and responsible objects', () {
      final json = Map<String, dynamic>.from(baseJson);
      json['opqs'] = [];
      json['client'] = {
        'id': 'client_id',
        'full_name': 'Client Name',
        'total_purchases_amount': 0,
        'total_purchases_count': 0,
      }; // Minimal ClientKanbanModel
      json['responsible'] = {
        'id': 'user_id',
        'first_name': 'User',
      }; // Minimal User

      final order = KanbanOrderModel.fromJson(json);
      expect(order.clientDetails, isNotNull);
      expect(order.clientDetails?.id, 'client_id');
      expect(order.responsibleData, isNotNull);
      expect(order.responsibleData?.id, 'user_id');
      // And the IDs in the base model should be extracted
      expect(order.client, 'client_id');
      expect(order.responsible, 'user_id');
    });

    // Test 7: KanbanOrderModel with client_car object
    test('KanbanOrderModel parses client_car object', () {
      final json = Map<String, dynamic>.from(baseJson);
      json['opqs'] = [];
      json['client_car'] = {
        'id': 99,
        'country': 'CL',
        'created_at': 'date',
        'updated_at': 'date',
        'car': {'id': 1, 'year': 2000, 'brand': 10}, // CarModel minimal
      };

      final order = KanbanOrderModel.fromJson(json);
      expect(order.clientCarDetails, isNotNull);
      expect(order.clientCarDetails?.id, 99);
      expect(order.clientCar, 99);
    });

    // Test 8: OrderDetailRespository fromJson
    test('OrderDetailRespository fromJson', () {
      final json = Map<String, dynamic>.from(baseJson);
      json['client'] = {
        'id': 'c1',
        'first_name': 'C',
        'created_at': '2022-01-01',
        'updated_at': '2022-01-01',
        'is_active': true,
        'is_available': true,
      }; // ClientModel
      json['responsible'] = {'id': 'r1', 'first_name': 'R'}; // UserModel

      final order = OrderDetailRespository.fromJson(json);
      expect(order.id, 1);
      expect(order.clientDetails, isNotNull);
      expect(order.clientDetails?.id, 'c1');
      expect(order.client, 'c1');
    });

    // Test 9: Nullable integers
    test('Nullable integers are handled', () {
      final json = Map<String, dynamic>.from(baseJson);
      json['estimated_ticket'] = null;
      json['ticket'] = null;
      final order = OrderModel.fromJson(json);
      expect(order.estimatedTicket, null);
      expect(order.ticket, null);
    });

    // Test 10: Boolean flags
    test('Boolean flags check', () {
      final json = Map<String, dynamic>.from(baseJson);
      json['is_proposal_sent'] = true;
      json['is_quotations_link_opened'] = true;
      final order = OrderModel.fromJson(json);
      expect(order.isProposalSent, true);
      expect(order.isQuotationsLinkOpened, true);
    });

    // Test 11: KanbanOrderModel OPQs parsing
    test('KanbanOrderModel parses OPQs', () {
      final json = Map<String, dynamic>.from(baseJson);
      json['opqs'] = [
        {
          'id': 101,
          'status': 'pending',
          // add other required OPQ fields if needed, relying on loose parsing or providing minimal
          // Checking order_product_quantity.dart might be needed if strict.
          // Assuming minimal for now or that OPQ has tolerant fromJson
          'name': 'Part 1',
          'quantity': 1,
          'is_guaranteed': false,
          'created_at': 'date',
          'updated_at': 'date',
        },
      ];
      final order = KanbanOrderModel.fromJson(json);
      expect(order.opqs.length, 1);
      expect(order.opqs.first.id, 101);
    });

    // Test 12: OrderDetailRepository handles null client/responsible objects (fallback to original string/int if not object?)
    // Actually the code tries to parse if present. If not present, it leaves as null?
    // Code says: client = json.containsKey("client") ...
    // If it's just a string ID in json['client'], ClientModel.fromJson might fail?
    // The code checks `json["client"] != null`. If it's a string, ClientModel.fromJson(String) ?? No, expects Map.
    // So if API returns ID string, this might crash. Assuming API returns Object here for this repo.
    test('OrderDetailRespository handles null details', () {
      final json = Map<String, dynamic>.from(baseJson);
      json.remove('client');
      json.remove('responsible');
      // baseJson has 'client': 'Client X' (string). If I remove it, it's null.

      final order = OrderDetailRespository.fromJson(json);
      expect(order.clientDetails, null);
      expect(order.responsibleDetails, null);
    });
  });
}
