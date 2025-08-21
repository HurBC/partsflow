class Order {
  final int id;
  final String? name;
  final OrderSourceChoicesType source;
  final OrderOperationModeEnumType operationMode;
  final OrderStatusChoicesType? prevStatus;
  final OrderStatusChoicesType status;
  final OrderStatusChoicesType? nextStatus;
  final String? estimatedCategory;
  final int? estimatedTicket;
  final OrderCarIdentificationStatusChoicesType? carIdentificationStatus;
  final OrderProductIdentificationStatusChoicesType?
  productIdentificationStatus;
  final int productRequestedCount;
  final int productIdentifiedCount;
  final OrderOemSearchStatusChoicesType? oemSearchStatus;
  final OrderStockSearchStatusChoicesType? stockSearchStatus;
  final CancelReasonsType? cancelReason;
  final bool isProposalSent;
  final bool isQuotationsLinkOpened;
  final bool? isAiMarkAsPurchase;
  final String? aiMarkAsPurchaseAt;
  final int subsidiary;
  final String client;
  final int clientCar;
  final String? responsible;
  final String? acceptedAt;
  final String? quotationsExpirationDate;
  final String? internalSaleNumber;
  final int? ticket;
  final OrderQuotationSubstateChoicesType? quotationSubstate;
  final String? quotationSubstateChangeDate;
  final bool isQuotationSubstateIdentifiedByAgent;
  final OrderPaymentMethodChoicesType? paymentMethod;
  final bool isPaymentIdentifiedByAgent;
  final String? paymentDate;
  final bool paymentVerified;
  final String? paymentVerifiedByMethod;
  final String? paymentVerifiedBy;
  final String? paymentVerifiedDate;
  final OrderDeliveryMethodType? deliveryMethod;
  final String? tentativeWithdrawalDate;
  final String? effectiveWithdrawalDate;
  final bool? isWithdrawalPersonClient;
  final String? tentativeShippingDate;
  final String? courier;
  final String? shippingTrackingNumber;
  final String createdAt;
  final String updatedAt;

  Order({
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
    required this.client,
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
}

enum OrderOperationModeEnumType { manual, automatic }

enum OrderSourceChoicesType {
  widget,
  whatsapp,
  backoffice,
  aiOrderTaker,
  aiAnalyzer,
  apiIntegration,
  other,
}

enum OrderStatusChoicesType {
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

enum CancelReasonsType {
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

enum OrderCarIdentificationStatusChoicesType {
  requestedPlate,
  requestedVin,
  requestedBrandModelYear,
  searchingPlateInformation,
  carUnidentified,
  finished,
}

enum OrderProductIdentificationStatusChoicesType {
  requestedProducts,
  requestedConfirmation,
  verifyingProducts,
  someProductsUnidentified,
  productsUnidentified,
}

enum OrderOemSearchStatusChoicesType {
  searchingOems,
  someOemsUnidentified,
  oemsUnidentified,
}

enum OrderStockSearchStatusChoicesType {
  searchingStock,
  someProductsNotFound,
  productsNotFound,
}

enum OrderImageContextChoicesType { other, transferReceipt }

enum ListOrderSortByCategoryType { categoryWeight, minusCategoryWeight }

enum ListOrderSortByCreatedAtType { createdAt, minusCreatedAt }

enum ListOrderSortByTicketType { estimatedTicket, minusEstimatedTicket }

enum OrderDeliveryMethodType { localWithdrawal, shipped }

enum OrderPaymentMethodChoicesType {
  webpay,
  bankTransfer,
  inPerson,
  partsflow,
  other,
}

enum OrderQuotationSubstateChoicesType {
  notInterested,
  technicalDoubt,
  logisticDoubt,
  priceIssue,
  otherInterested,
}
