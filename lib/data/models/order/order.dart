import 'package:partsflow/data/models/cars/client_car.dart';
import 'package:partsflow/data/models/clients/client.dart';
import 'package:partsflow/data/models/clients/client_kanban.dart';
import 'package:partsflow/data/models/order/enums/order_enums.dart';
import 'package:partsflow/data/models/order/order_product_quantity.dart';
import 'package:partsflow/data/models/users/user.dart';

class OrderRepository {
  final int id;
  final String? name;
  final OrderSourceChoices? source;
  final OrderOperationModeEnum operationMode;
  final OrderStatusChoices? prevStatus;
  final OrderStatusChoices status;
  final OrderStatusChoices? nextStatus;
  final String? estimatedCategory;
  final int? estimatedTicket;
  final OrderCarIdentificationStatusChoices? carIdentificationStatus;
  final OrderProductIdentificationStatusChoices? productIdentificationStatus;
  final int productRequestedCount;
  final int productIdentifiedCount;
  final OrderOemSearchStatusChoices? oemSearchStatus;
  final OrderStockSearchStatusChoices? stockSearchStatus;
  final CancelReasons? cancelReason;
  final bool isProposalSent;
  final bool isQuotationsLinkOpened;
  final bool? isAiMarkAsPurchase;
  final String? aiMarkAsPurchaseAt;
  final String subsidiary;
  final String? client;
  final int clientCar;
  final String? responsible;
  final String? acceptedAt;
  final String? quotationsExpirationDate;
  final String? internalSaleNumber;
  final int? ticket;
  final OrderQuotationSubstateChoices? quotationSubstate;
  final String? quotationSubstateChangeDate;
  final bool isQuotationSubstateIdentifiedByAgent;
  final OrderPaymentMethodChoices? paymentMethod;
  final bool isPaymentIdentifiedByAgent;
  final String? paymentDate;
  final bool paymentVerified;
  final String? paymentVerifiedByMethod;
  final String? paymentVerifiedBy;
  final String? paymentVerifiedDate;
  final OrderDeliveryMethod? deliveryMethod;
  final String? tentativeWithdrawalDate;
  final String? effectiveWithdrawalDate;
  final bool? isWithdrawalPersonClient;
  final String? tentativeShippingDate;
  final String? courier;
  final String? shippingTrackingNumber;
  final String createdAt;
  final String updatedAt;

  OrderRepository({
    required this.id,
    required this.name,
    this.source,
    required this.operationMode,
    required this.prevStatus,
    required this.status,
    required this.nextStatus,
    required this.estimatedCategory,
    required this.estimatedTicket,
    required this.carIdentificationStatus,
    required this.productIdentificationStatus,
    required this.productRequestedCount,
    required this.productIdentifiedCount,
    required this.oemSearchStatus,
    required this.stockSearchStatus,
    required this.cancelReason,
    required this.isProposalSent,
    required this.isQuotationsLinkOpened,
    required this.isAiMarkAsPurchase,
    required this.aiMarkAsPurchaseAt,
    required this.subsidiary,
    this.client,
    required this.clientCar,
    required this.responsible,
    required this.acceptedAt,
    required this.quotationsExpirationDate,
    required this.internalSaleNumber,
    required this.ticket,
    required this.quotationSubstate,
    required this.quotationSubstateChangeDate,
    required this.isQuotationSubstateIdentifiedByAgent,
    required this.paymentMethod,
    required this.isPaymentIdentifiedByAgent,
    required this.paymentDate,
    required this.paymentVerified,
    required this.paymentVerifiedByMethod,
    required this.paymentVerifiedBy,
    required this.paymentVerifiedDate,
    required this.deliveryMethod,
    required this.tentativeWithdrawalDate,
    required this.effectiveWithdrawalDate,
    required this.isWithdrawalPersonClient,
    required this.tentativeShippingDate,
    required this.courier,
    required this.shippingTrackingNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderRepository.fromJson(Map<String, dynamic> json) {
    return OrderRepository(
      id: json['id'] as int,
      name: json['name'] as String?,
      source: OrderSourceChoicesExtension.fromJson(json['source']),
      operationMode: OrderOperationModeEnumExtension.fromJson(
        json['operation_mode'],
      )!,
      prevStatus: json['prev_status'] != null
          ? OrderStatusChoicesExtension.fromJson(json['prev_status'])
          : null,
      status: OrderStatusChoicesExtension.fromJson(json['status'])!,
      nextStatus: json['next_status'] != null
          ? OrderStatusChoicesExtension.fromJson(json['next_status'])
          : null,
      estimatedCategory: json['estimated_category'] as String?,
      estimatedTicket: json['estimated_ticket'] as int?,
      carIdentificationStatus: json['car_identification_status'] != null
          ? OrderCarIdentificationStatusChoicesExtension.fromJson(
              json['car_identification_status'],
            )
          : null,
      productIdentificationStatus: json['product_identification_status'] != null
          ? OrderProductIdentificationStatusChoicesExtension.fromJson(
              json['product_identification_status'],
            )
          : null,
      productRequestedCount: json['product_requested_count'] as int,
      productIdentifiedCount: json['product_identified_count'] as int,
      oemSearchStatus: json['oem_search_status'] != null
          ? OrderOemSearchStatusChoicesExtension.fromJson(
              json['oem_search_status'],
            )
          : null,
      stockSearchStatus: json['stock_search_status'] != null
          ? OrderStockSearchStatusChoicesExtension.fromJson(
              json['stock_search_status'],
            )
          : null,
      cancelReason: json['cancel_reason'] != null
          ? CancelReasonsExtension.fromJson(json['cancel_reason'])
          : null,
      isProposalSent: json['is_proposal_sent'] as bool,
      isQuotationsLinkOpened: json['is_quotations_link_opened'] as bool,
      isAiMarkAsPurchase: json['is_ai_mark_as_purchase'] as bool?,
      aiMarkAsPurchaseAt: json['ai_mark_as_purchase_at'] as String?,
      subsidiary: json['subsidiary'] as String,
      client: json['client'] as String?,
      clientCar: json['client_car'] ?? -1,
      responsible: json['responsible'] as String?,
      acceptedAt: json['accepted_at'] as String?,
      quotationsExpirationDate: json['quotations_expiration_date'] as String?,
      internalSaleNumber: json['internal_sale_number'] as String?,
      ticket: json['ticket'] as int?,
      quotationSubstate: json['quotation_substate'] != null
          ? OrderQuotationSubstateChoicesExtension.fromJson(
              json['quotation_substate'],
            )
          : null,
      quotationSubstateChangeDate:
          json['quotation_substate_change_date'] as String?,
      isQuotationSubstateIdentifiedByAgent:
          json['is_quotation_substate_identified_by_agent'] as bool,
      paymentMethod: json['payment_method'] != null
          ? OrderPaymentMethodChoicesExtension.fromJson(json['payment_method'])
          : null,
      isPaymentIdentifiedByAgent:
          json['is_payment_identified_by_agent'] as bool,
      paymentDate: json['payment_date'] as String?,
      paymentVerified: json['payment_verified'] as bool,
      paymentVerifiedByMethod: json['payment_verified_by_method'] as String?,
      paymentVerifiedBy: json['payment_verified_by'] as String?,
      paymentVerifiedDate: json['payment_verified_date'] as String?,
      deliveryMethod: json['delivery_method'] != null
          ? OrderDeliveryMethodExtension.fromJson(json['delivery_method'])
          : null,
      tentativeWithdrawalDate: json['tentative_withdrawal_date'] as String?,
      effectiveWithdrawalDate: json['effective_withdrawal_date'] as String?,
      isWithdrawalPersonClient: json['is_withdrawal_person_client'] as bool?,
      tentativeShippingDate: json['tentative_shipping_date'] as String?,
      courier: json['courier'] as String?,
      shippingTrackingNumber: json['shipping_tracking_number'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }
}

class KanbanOrderRepository extends OrderRepository {
  final ClientKanbanRepository? clientDetails;
  final ClientCarSimpleCar? clientCarDetails;
  final List<OrderProductQuantityRepository> opqs;
  final UserRepository? responsibleData;

  KanbanOrderRepository({
    required super.id,
    required super.name,
    required super.source,
    required super.operationMode,
    required super.prevStatus,
    required super.status,
    required super.nextStatus,
    required super.estimatedCategory,
    required super.estimatedTicket,
    required super.carIdentificationStatus,
    required super.productIdentificationStatus,
    required super.productRequestedCount,
    required super.productIdentifiedCount,
    required super.oemSearchStatus,
    required super.stockSearchStatus,
    required super.cancelReason,
    required super.isProposalSent,
    required super.isQuotationsLinkOpened,
    required super.isAiMarkAsPurchase,
    required super.aiMarkAsPurchaseAt,
    required super.subsidiary,
    required super.client,
    required super.clientCar,
    required super.responsible,
    required super.acceptedAt,
    required super.quotationsExpirationDate,
    required super.internalSaleNumber,
    required super.ticket,
    required super.quotationSubstate,
    required super.quotationSubstateChangeDate,
    required super.isQuotationSubstateIdentifiedByAgent,
    required super.paymentMethod,
    required super.isPaymentIdentifiedByAgent,
    required super.paymentDate,
    required super.paymentVerified,
    required super.paymentVerifiedByMethod,
    required super.paymentVerifiedBy,
    required super.paymentVerifiedDate,
    required super.deliveryMethod,
    required super.tentativeWithdrawalDate,
    required super.effectiveWithdrawalDate,
    required super.isWithdrawalPersonClient,
    required super.tentativeShippingDate,
    required super.courier,
    required super.shippingTrackingNumber,
    required super.createdAt,
    required super.updatedAt,
    required this.clientDetails,
    this.clientCarDetails,
    required this.opqs,
    this.responsibleData,
  });

  factory KanbanOrderRepository.fromJson(Map<String, dynamic> json) {
    var decodedOpqs = List<OrderProductQuantityRepository>.empty(
      growable: true,
    );

    for (var opq in json["opqs"] as List) {
      var decodedOpq = OrderProductQuantityRepository.fromJson(opq);

      decodedOpqs.add(decodedOpq);
    }

    UserRepository? responsible =
        json.containsKey("responsible") && json["responsible"] != null
        ? UserRepository.fromJson(json["responsible"])
        : null;

    ClientKanbanRepository client = ClientKanbanRepository.fromJson(
      json['client'],
    );

    ClientCarSimpleCar? clientCar =
        json.containsKey("client_car") && json["client_car"] != null
        ? ClientCarSimpleCar.fromJson(json["client_car"])
        : null;

    json.remove("responsible");
    json.remove("client");
    json.remove("client_car");

    final baseOrder = OrderRepository.fromJson(json);

    return KanbanOrderRepository(
      id: baseOrder.id,
      name: baseOrder.name,
      source: baseOrder.source,
      operationMode: baseOrder.operationMode,
      prevStatus: baseOrder.prevStatus,
      status: baseOrder.status,
      nextStatus: baseOrder.nextStatus,
      estimatedCategory: baseOrder.estimatedCategory,
      estimatedTicket: baseOrder.estimatedTicket,
      carIdentificationStatus: baseOrder.carIdentificationStatus,
      productIdentificationStatus: baseOrder.productIdentificationStatus,
      productRequestedCount: baseOrder.productRequestedCount,
      productIdentifiedCount: baseOrder.productIdentifiedCount,
      oemSearchStatus: baseOrder.oemSearchStatus,
      stockSearchStatus: baseOrder.stockSearchStatus,
      cancelReason: baseOrder.cancelReason,
      isProposalSent: baseOrder.isProposalSent,
      isQuotationsLinkOpened: baseOrder.isQuotationsLinkOpened,
      isAiMarkAsPurchase: baseOrder.isAiMarkAsPurchase,
      aiMarkAsPurchaseAt: baseOrder.aiMarkAsPurchaseAt,
      subsidiary: baseOrder.subsidiary,
      client: client.id ?? "",
      clientCar: clientCar?.id ?? -1,
      responsible: responsible?.id ?? "",
      acceptedAt: baseOrder.acceptedAt,
      quotationsExpirationDate: baseOrder.quotationsExpirationDate,
      internalSaleNumber: baseOrder.internalSaleNumber,
      ticket: baseOrder.ticket,
      quotationSubstate: baseOrder.quotationSubstate,
      quotationSubstateChangeDate: baseOrder.quotationSubstateChangeDate,
      isQuotationSubstateIdentifiedByAgent:
          baseOrder.isQuotationSubstateIdentifiedByAgent,
      paymentMethod: baseOrder.paymentMethod,
      isPaymentIdentifiedByAgent: baseOrder.isPaymentIdentifiedByAgent,
      paymentDate: baseOrder.paymentDate,
      paymentVerified: baseOrder.paymentVerified,
      paymentVerifiedByMethod: baseOrder.paymentVerifiedByMethod,
      paymentVerifiedBy: baseOrder.paymentVerifiedBy,
      paymentVerifiedDate: baseOrder.paymentVerifiedDate,
      deliveryMethod: baseOrder.deliveryMethod,
      tentativeWithdrawalDate: baseOrder.tentativeWithdrawalDate,
      effectiveWithdrawalDate: baseOrder.effectiveWithdrawalDate,
      isWithdrawalPersonClient: baseOrder.isWithdrawalPersonClient,
      tentativeShippingDate: baseOrder.tentativeShippingDate,
      courier: baseOrder.courier,
      shippingTrackingNumber: baseOrder.shippingTrackingNumber,
      createdAt: baseOrder.createdAt,
      updatedAt: baseOrder.updatedAt,
      clientDetails: client,
      clientCarDetails: clientCar,
      opqs: decodedOpqs,
      responsibleData: responsible,
    );
  }
}

class OrderDetailRespository extends OrderRepository {
  final ClientRepository? clientDetails;
  final UserRepository? responsibleDetails;

  OrderDetailRespository({
    required super.id,
    required super.name,
    required super.operationMode,
    required super.prevStatus,
    required super.status,
    required super.nextStatus,
    required super.estimatedCategory,
    required super.client,
    required super.estimatedTicket,
    required super.carIdentificationStatus,
    required super.productIdentificationStatus,
    required super.productRequestedCount,
    required super.productIdentifiedCount,
    required super.oemSearchStatus,
    required super.stockSearchStatus,
    required super.cancelReason,
    required super.isProposalSent,
    required super.isQuotationsLinkOpened,
    required super.isAiMarkAsPurchase,
    required super.aiMarkAsPurchaseAt,
    required super.subsidiary,
    required super.clientCar,
    required super.acceptedAt,
    required super.quotationsExpirationDate,
    required super.internalSaleNumber,
    required super.ticket,
    required super.quotationSubstate,
    required super.quotationSubstateChangeDate,
    required super.isQuotationSubstateIdentifiedByAgent,
    required super.paymentMethod,
    required super.isPaymentIdentifiedByAgent,
    required super.paymentDate,
    required super.paymentVerified,
    required super.paymentVerifiedByMethod,
    required super.paymentVerifiedBy,
    required super.paymentVerifiedDate,
    required super.deliveryMethod,
    required super.tentativeWithdrawalDate,
    required super.effectiveWithdrawalDate,
    required super.isWithdrawalPersonClient,
    required super.tentativeShippingDate,
    required super.courier,
    required super.shippingTrackingNumber,
    required super.createdAt,
    required super.updatedAt,
    required super.source,
    this.clientDetails,
    this.responsibleDetails, required super.responsible
  });

  factory OrderDetailRespository.fromJson(Map<String, dynamic> json) {
    ClientRepository? client = json.containsKey("client") && json["client"] != null ?
    ClientRepository.fromJson(json["client"]) : null;

    UserRepository? responsible = json.containsKey("responsible") && json["responsible"] != null ?
    UserRepository.fromJson(json["responsible"]) : null;

    json.remove("client");
    json.remove("responsible");

    final baseOrder = OrderRepository.fromJson(json);

    return OrderDetailRespository(
      id: baseOrder.id,
      name: baseOrder.name,
      source: baseOrder.source,
      operationMode: baseOrder.operationMode,
      prevStatus: baseOrder.prevStatus,
      status: baseOrder.status,
      nextStatus: baseOrder.nextStatus,
      estimatedCategory: baseOrder.estimatedCategory,
      estimatedTicket: baseOrder.estimatedTicket,
      carIdentificationStatus: baseOrder.carIdentificationStatus,
      productIdentificationStatus: baseOrder.productIdentificationStatus,
      productRequestedCount: baseOrder.productRequestedCount,
      productIdentifiedCount: baseOrder.productIdentifiedCount,
      oemSearchStatus: baseOrder.oemSearchStatus,
      stockSearchStatus: baseOrder.stockSearchStatus,
      cancelReason: baseOrder.cancelReason,
      isProposalSent: baseOrder.isProposalSent,
      isQuotationsLinkOpened: baseOrder.isQuotationsLinkOpened,
      isAiMarkAsPurchase: baseOrder.isAiMarkAsPurchase,
      aiMarkAsPurchaseAt: baseOrder.aiMarkAsPurchaseAt,
      subsidiary: baseOrder.subsidiary,
      client: client?.id,
      clientCar: baseOrder.clientCar,
      responsible: responsible?.id,
      acceptedAt: baseOrder.acceptedAt,
      quotationsExpirationDate: baseOrder.quotationsExpirationDate,
      internalSaleNumber: baseOrder.internalSaleNumber,
      ticket: baseOrder.ticket,
      quotationSubstate: baseOrder.quotationSubstate,
      quotationSubstateChangeDate: baseOrder.quotationSubstateChangeDate,
      isQuotationSubstateIdentifiedByAgent:
          baseOrder.isQuotationSubstateIdentifiedByAgent,
      paymentMethod: baseOrder.paymentMethod,
      isPaymentIdentifiedByAgent: baseOrder.isPaymentIdentifiedByAgent,
      paymentDate: baseOrder.paymentDate,
      paymentVerified: baseOrder.paymentVerified,
      paymentVerifiedByMethod: baseOrder.paymentVerifiedByMethod,
      paymentVerifiedBy: baseOrder.paymentVerifiedBy,
      paymentVerifiedDate: baseOrder.paymentVerifiedDate,
      deliveryMethod: baseOrder.deliveryMethod,
      tentativeWithdrawalDate: baseOrder.tentativeWithdrawalDate,
      effectiveWithdrawalDate: baseOrder.effectiveWithdrawalDate,
      isWithdrawalPersonClient: baseOrder.isWithdrawalPersonClient,
      tentativeShippingDate: baseOrder.tentativeShippingDate,
      courier: baseOrder.courier,
      shippingTrackingNumber: baseOrder.shippingTrackingNumber,
      createdAt: baseOrder.createdAt,
      updatedAt: baseOrder.updatedAt,
      clientDetails: client,
      responsibleDetails: responsible,
    );}
}
