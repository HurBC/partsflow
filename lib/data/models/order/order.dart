class Order {
  final int id;
  final String? name;
  final OrderSourceEnum source;
  final OrderOperationModeEnum operationMode;

}

enum OrderSourceEnum {
  widget,
  whatsapp,
  backoffice,
  aiOrderTaker,
  aiAnalizer,
  apiIntegratio,
  other
}

enum OrderOperationModeEnum {
  manual,
  automatic
}

enum OrderStatusEnum {
  draft,
  request,
  identifying_car,
  identifying_products,
  searching_oems,
  searching_stock,
  order_quoted,
  quotation_sent,
  options_accepted,
  purchase_completed,
  finished,
  canceled,
  devolution_requested,
  unmanaged,
}
