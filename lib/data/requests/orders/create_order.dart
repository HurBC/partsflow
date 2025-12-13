import 'package:partsflow/core/models/json.dart';
import 'package:partsflow/data/models/order/enums/order_enums.dart';

class CreateOrder extends ToJson {
  String? name;
  OrderSourceChoices? source;
  OrderOperationModeEnum? operationMode;
  OrderStatusChoices? prevStatus;
  OrderStatusChoices? status;
  OrderStatusChoices? nextStatus;
  String? estimatedCategory;
  int? estimatedTicket;
  OrderCarIdentificationStatusChoices? carIdentificationStatus;
  OrderProductIdentificationStatusChoices? productIdentificationStatus;
  int? productRequestedCount;
  int? productIdentifiedCount;
  OrderOemSearchStatusChoices? oemSearchStatus;
  OrderStockSearchStatusChoices? stockSearchStatus;
  CancelReasons? cancelReason;
  bool? isProposalSent;
  bool? isQuotationsLinkOpened;
  bool? isAiMarkAsPurchase;
  String? aiMarkAsPurchaseAt;
  String? subsidiary;
  String? client;
  int? clientCar;
  String? responsible;
  String? acceptedAt;
  String? quotationsExpirationDate;
  String? internalSaleNumber;
  int? ticket;
  OrderQuotationSubstateChoices? quotationSubstate;
  String? quotationSubstateChangeDate;
  bool? isQuotationSubstateIdentifiedByAgent;
  OrderPaymentMethodChoices? paymentMethod;
  bool? isPaymentIdentifiedByAgent;
  String? paymentDate;
  bool? paymentVerified;
  String? paymentVerifiedByMethod;
  String? paymentVerifiedBy;
  String? paymentVerifiedDate;
  OrderDeliveryMethod? deliveryMethod;
  String? tentativeWithdrawalDate;
  String? effectiveWithdrawalDate;
  bool? isWithdrawalPersonClient;
  String? tentativeShippingDate;
  String? courier;
  String? shippingTrackingNumber;
  String? createdAt;
  String? updatedAt;

  CreateOrder({
  this.name,
  this.source,
  this.operationMode,
  this.prevStatus,
  this.status,
  this.nextStatus,
  this.estimatedCategory,
  this.estimatedTicket,
  this.carIdentificationStatus,
  this.productIdentificationStatus,
  this.productRequestedCount,
  this.productIdentifiedCount,
  this.oemSearchStatus,
  this.stockSearchStatus,
  this.cancelReason,
  this.isProposalSent,
  this.isQuotationsLinkOpened,
  this.isAiMarkAsPurchase,
  this.aiMarkAsPurchaseAt,
  this.subsidiary,
  this.client,
  this.clientCar,
  this.responsible,
  this.acceptedAt,
  this.quotationsExpirationDate,
  this.internalSaleNumber,
  this.ticket,
  this.quotationSubstate,
  this.quotationSubstateChangeDate,
  this.isQuotationSubstateIdentifiedByAgent,
  this.paymentMethod,
  this.isPaymentIdentifiedByAgent,
  this.paymentDate,
  this.paymentVerified,
  this.paymentVerifiedByMethod,
  this.paymentVerifiedBy,
  this.paymentVerifiedDate,
  this.deliveryMethod,
  this.tentativeWithdrawalDate,
  this.effectiveWithdrawalDate,
  this.isWithdrawalPersonClient,
  this.tentativeShippingDate,
  this.courier,
  this.shippingTrackingNumber,
  this.createdAt,
  this.updatedAt,
});


  @override
  Map<String, dynamic> toJson() {
    final data = {
      "name": name,
      "source": source?.toJson(),
      "operationMode": operationMode?.toJson(),
      "prevStatus": prevStatus?.toJson(),
      "status": status?.toJson(),
      "nextStatus": nextStatus?.toJson(),
      "estimatedCategory": estimatedCategory,
      "estimatedTicket": estimatedTicket,
      "carIdentificationStatus": carIdentificationStatus?.toJson(),
      "productIdentificationStatus": productIdentificationStatus?.toJson(),
      "productRequestedCount": productRequestedCount,
      "productIdentifiedCount": productIdentifiedCount,
      "oemSearchStatus": oemSearchStatus?.toJson(),
      "stockSearchStatus": stockSearchStatus?.toJson(),
      "cancelReason": cancelReason?.toJson(),
      "isProposalSent": isProposalSent,
      "isQuotationsLinkOpened": isQuotationsLinkOpened,
      "isAiMarkAsPurchase": isAiMarkAsPurchase,
      "aiMarkAsPurchaseAt": aiMarkAsPurchaseAt,
      "subsidiary": subsidiary,
      "client": client,
      "clientCar": clientCar,
      "responsible": responsible,
      "acceptedAt": acceptedAt,
      "quotationsExpirationDate": quotationsExpirationDate,
      "internalSaleNumber": internalSaleNumber,
      "ticket": ticket,
      "quotationSubstate": quotationSubstate?.toJson(),
      "quotationSubstateChangeDate": quotationSubstateChangeDate,
      "isQuotationSubstateIdentifiedByAgent":
          isQuotationSubstateIdentifiedByAgent,
      "paymentMethod": paymentMethod?.toJson(),
      "isPaymentIdentifiedByAgent": isPaymentIdentifiedByAgent,
      "paymentDate": paymentDate,
      "paymentVerified": paymentVerified,
      "paymentVerifiedByMethod": paymentVerifiedByMethod,
      "paymentVerifiedBy": paymentVerifiedBy,
      "paymentVerifiedDate": paymentVerifiedDate,
      "deliveryMethod": deliveryMethod?.toJson(),
      "tentativeWithdrawalDate": tentativeWithdrawalDate,
      "effectiveWithdrawalDate": effectiveWithdrawalDate,
      "isWithdrawalPersonClient": isWithdrawalPersonClient,
      "tentativeShippingDate": tentativeShippingDate,
      "courier": courier,
      "shippingTrackingNumber": shippingTrackingNumber,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };

    data.removeWhere((key, value) => value == null);

    return data;
  }
}
