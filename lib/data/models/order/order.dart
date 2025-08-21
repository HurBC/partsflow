import 'package:collection/collection.dart';
import 'package:partsflow/data/models/cars/client_car.dart';
import 'package:partsflow/data/models/cliients/client_kanban.dart';
import 'package:partsflow/data/models/order/order_product_quantity.dart';
import 'package:partsflow/data/models/users/user.dart';

class OrderRepository {
  final int id;
  final String? name;
  final OrderSourceChoices source;
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
    required this.source,
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
      source: OrderSourceChoicesExtension.fromJson(json['source'])!,
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

class KanbanOrderRepostory extends OrderRepository {
  final ClientKanbanRepository clientDetails;
  final ClientCarSimpleCar? clientCarDetails;
  final List<OrderProductQuantityRepository> opqs;
  final UserRepository? responsibleData;

  KanbanOrderRepostory({
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

  factory KanbanOrderRepostory.fromJson(Map<String, dynamic> json) {
    var decodedOpqs = List<OrderProductQuantityRepository>.empty(growable: true);

    for (var opq in json["opqs"] as List) {
      var decodedOpq = OrderProductQuantityRepository.fromJson(opq);

      decodedOpqs.add(decodedOpq);
    }

    UserRepository? responsible = json.containsKey("responsible") && json["responsible"] != null
        ? UserRepository.fromJson(json["responsible"])
        : null;
    
    ClientKanbanRepository client = ClientKanbanRepository.fromJson(json['client']);
    
    ClientCarSimpleCar? clientCar = json.containsKey("client_car") && json["client_car"] != null
          ? ClientCarSimpleCar.fromJson(json["client_car"])
          : null;

    json.remove("responsible");
    json.remove("client");
    json.remove("client_car");

    final baseOrder = OrderRepository.fromJson(json);

    return KanbanOrderRepostory(
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

enum OrderOperationModeEnum { manual, automatic }

enum OrderSourceChoices {
  widget,
  whatsapp,
  backoffice,
  aiOrderTaker,
  aiAnalyzer,
  apiIntegration,
  other,
}

enum OrderStatusChoices {
  draft,
  request,
  identifyingCar,
  identifyingProducts,
  searchingOems,
  searchingStock,
  orderQuoted,
  quotationSent,
  optionsAccepted,
  purchaseCompleted,
  finished,
  canceled,
  devolutionRequested,
  unmanaged,
}

enum CancelReasons {
  highPrice,
  noResponse,
  error,
  isDuplicated,
  noReason,
  noClientResponse,
  unmanaged,
  unavailableBrand,
  unavailableProducts,
  invalidVehicleYear,
  noStock,
  notInteresting,
}

enum OrderCarIdentificationStatusChoices {
  requestedPlate,
  requestedVin,
  requestedBrandModelYear,
  searchingPlateInformation,
  carUnidentified,
  finished,
}

enum OrderProductIdentificationStatusChoices {
  requestedProducts,
  requestedConfirmation,
  verifyingProducts,
  someProductsUnidentified,
  productsUnidentified,
}

enum OrderOemSearchStatusChoices {
  searchingOems,
  someOemsUnidentified,
  oemsUnidentified,
}

enum OrderStockSearchStatusChoices {
  searchingStock,
  someProductsNotFound,
  productsNotFound,
}

enum OrderImageContextChoices { other, transferReceipt }

enum ListOrderSortByCategory { categoryWeight, minusCategoryWeight }

enum ListOrderSortByCreatedAt { createdAt, minusCreatedAt }

enum ListOrderSortByTicket { estimatedTicket, minusEstimatedTicket }

enum OrderDeliveryMethod { localWithdrawal, shipped }

enum OrderPaymentMethodChoices {
  webpay,
  bankTransfer,
  inPerson,
  partsflow,
  other,
}

enum OrderQuotationSubstateChoices {
  notInterested,
  technicalDoubt,
  logisticDoubt,
  priceIssue,
  otherInterested,
}

// --------------- HELPERS ---------------

String _toSnakeCase(String str) {
  return str
      .replaceAllMapped(
        RegExp(r'(?<!^)(?=[A-Z])'),
        (match) => '_${match.group(0)}',
      )
      .toLowerCase();
}

// --------------- EXTENSIONS ---------------

extension OrderOperationModeEnumExtension on OrderOperationModeEnum {
  String toJson() => _toSnakeCase(name);

  static OrderOperationModeEnum? fromJson(String json) {
    return OrderOperationModeEnum.values.firstWhereOrNull(
      (e) => e.toJson() == json,
    );
  }
}

extension OrderSourceChoicesExtension on OrderSourceChoices {
  String toJson() => _toSnakeCase(name);

  static OrderSourceChoices? fromJson(String json) {
    return OrderSourceChoices.values.firstWhereOrNull(
      (e) => e.toJson() == json,
    );
  }
}

extension OrderStatusChoicesExtension on OrderStatusChoices {
  String toJson() => _toSnakeCase(name);

  static OrderStatusChoices? fromJson(String json) {
    return OrderStatusChoices.values.firstWhereOrNull(
      (e) => e.toJson() == json,
    );
  }
}

extension CancelReasonsExtension on CancelReasons {
  String toJson() => _toSnakeCase(name);

  static CancelReasons? fromJson(String json) {
    return CancelReasons.values.firstWhereOrNull((e) => e.toJson() == json);
  }
}

extension OrderCarIdentificationStatusChoicesExtension
    on OrderCarIdentificationStatusChoices {
  String toJson() => _toSnakeCase(name);

  static OrderCarIdentificationStatusChoices? fromJson(String json) {
    return OrderCarIdentificationStatusChoices.values.firstWhereOrNull(
      (e) => e.toJson() == json,
    );
  }
}

extension OrderProductIdentificationStatusChoicesExtension
    on OrderProductIdentificationStatusChoices {
  String toJson() => _toSnakeCase(name);

  static OrderProductIdentificationStatusChoices? fromJson(String json) {
    return OrderProductIdentificationStatusChoices.values.firstWhereOrNull(
      (e) => e.toJson() == json,
    );
  }
}

extension OrderOemSearchStatusChoicesExtension on OrderOemSearchStatusChoices {
  String toJson() => _toSnakeCase(name);

  static OrderOemSearchStatusChoices? fromJson(String json) {
    return OrderOemSearchStatusChoices.values.firstWhereOrNull(
      (e) => e.toJson() == json,
    );
  }
}

extension OrderStockSearchStatusChoicesExtension
    on OrderStockSearchStatusChoices {
  String toJson() => _toSnakeCase(name);

  static OrderStockSearchStatusChoices? fromJson(String json) {
    return OrderStockSearchStatusChoices.values.firstWhereOrNull(
      (e) => e.toJson() == json,
    );
  }
}

extension OrderImageContextChoicesExtension on OrderImageContextChoices {
  String toJson() => _toSnakeCase(name);

  static OrderImageContextChoices? fromJson(String json) {
    return OrderImageContextChoices.values.firstWhereOrNull(
      (e) => e.toJson() == json,
    );
  }
}

extension ListOrderSortByCategoryExtension on ListOrderSortByCategory {
  String toJson() => _toSnakeCase(name);

  static ListOrderSortByCategory? fromJson(String json) {
    return ListOrderSortByCategory.values.firstWhereOrNull(
      (e) => e.toJson() == json,
    );
  }
}

extension ListOrderSortByCreatedAtExtension on ListOrderSortByCreatedAt {
  String toJson() => _toSnakeCase(name);

  static ListOrderSortByCreatedAt? fromJson(String json) {
    return ListOrderSortByCreatedAt.values.firstWhereOrNull(
      (e) => e.toJson() == json,
    );
  }
}

extension ListOrderSortByTicketExtension on ListOrderSortByTicket {
  String toJson() => _toSnakeCase(name);

  static ListOrderSortByTicket? fromJson(String json) {
    return ListOrderSortByTicket.values.firstWhereOrNull(
      (e) => e.toJson() == json,
    );
  }
}

extension OrderDeliveryMethodExtension on OrderDeliveryMethod {
  String toJson() => _toSnakeCase(name);

  static OrderDeliveryMethod? fromJson(String json) {
    return OrderDeliveryMethod.values.firstWhereOrNull(
      (e) => e.toJson() == json,
    );
  }
}

extension OrderPaymentMethodChoicesExtension on OrderPaymentMethodChoices {
  String toJson() => _toSnakeCase(name);

  static OrderPaymentMethodChoices? fromJson(String json) {
    return OrderPaymentMethodChoices.values.firstWhereOrNull(
      (e) => e.toJson() == json,
    );
  }
}

extension OrderQuotationSubstateChoicesExtension
    on OrderQuotationSubstateChoices {
  String toJson() => _toSnakeCase(name);

  static OrderQuotationSubstateChoices? fromJson(String json) {
    return OrderQuotationSubstateChoices.values.firstWhereOrNull(
      (e) => e.toJson() == json,
    );
  }
}
