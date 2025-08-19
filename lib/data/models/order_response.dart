class OrderResponse {
  final int id;
  final String? name;
  final OrderSourceEnum source;
  final OrderOperationModeEnum operationMode;
  final OrderStatusChoicesEnum? prevStatus;
  final OrderStatusChoicesEnum status;
  final OrderStatusChoicesEnum? nextStatus;
  final String? estimatedCategory;
  final int? estimatedTicket;
  final OrderCarIdentificationStatusEnum? carIdentificationStatus;
  final OrderProductIdentificationStatusEnum? productIdentificationStatus;
  final int productRequestedCount;
  final int productIdentifiedCount;
  final OrderOemSearchStatusEnum? oemSearchStatus;
  final OrderStockSearchStatusEnum? stockSearchStatus;
  final CancelReasonsEnum? cancelReason;
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

  // Quotation Sent Substate
  final OrderQuotationSubstateEnum? quotationSubstate;
  final String? quotationSubstateChangeDate;
  final bool isQuotationSubstateIdentifiedByAgent;

  // Payment Info
  final OrderPaymentMethodEnum? paymentMethod;
  final bool isPaymentIdentifiedByAgent;
  final String? paymentDate;
  final bool paymentVerified;
  final String? paymentVerifiedByMethod;
  final String? paymentVerifiedBy;
  final String? paymentVerifiedDate;

  // Delivery Info
  final OrderDeliveryMethodType? deliveryMethod;
  final String? tentativeWithdrawalDate;
  final String? effectiveWithdrawalDate;
  final bool? isWithdrawalPersonClient;
  final String? tentativeShippingDate;
  final String? courier;
  final String? shippingTrackingNumber;

  // Dates
  final String createdAt;
  final String updatedAt;

  OrderResponse({
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

enum OrderSourceEnum {
  widget,
  whatsapp,
  backoffice,
  aiOrderTaker,
  aiAnalyzer,
  apiIntegration,
  other,
}

enum OrderStatusChoicesEnum {
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

enum OrderOperationModeEnum { manual, automatic }

enum OrderCarIdentificationStatusEnum {
  requestedPlate,
  requestedVin,
  requestedBrandModelYear,
  searchingPlateInformation,
  carUnidentified,
  finished,
}

enum OrderProductIdentificationStatusEnum {
  requestedProducts,
  requestedConfirmation,
  verifyingProducts,
  someProductsUnidentified,
  productsUnidentified,
}

enum OrderOemSearchStatusEnum {
  searchingOems,
  someOemsUnidentified,
  oemsUnidentified,
}

enum OrderStockSearchStatusEnum {
  searchingStock,
  someProductsNotFound,
  productsNotFound,
}

enum CancelReasonsEnum {
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

enum OrderQuotationSubstateEnum {
  notInterested,
  technicalDoubt,
  logisticDoubt,
  priceIssue,
  otherInterested,
}

enum OrderPaymentMethodEnum { webpay, bankTransfer, inPerson, partsflow, other }

enum OrderDeliveryMethodType { localWithdrawal, shipped }
