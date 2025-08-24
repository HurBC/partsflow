import 'package:collection/collection.dart';

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
