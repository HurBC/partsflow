import 'package:partsflow/core/models/json.dart';
import 'package:partsflow/data/abstract_models/products/simple_product.dart';
import 'package:partsflow/data/models/order/enums/order_enums.dart';

class UpdateDraftOrder extends ToJson {
  final int id;
  OrderStatusChoices? status;
  String? client;
  int? clientCar;
  String? responsible;
  List<SimpleProduct>? products;

  UpdateDraftOrder({
    required this.id,
    this.client,
    this.clientCar,
    this.responsible,
    this.products,
    this.status,
  });

  @override
  Map<String, dynamic> toJson() {
    final data = {
      "status": status?.toJson(),
      "client": client,
      "client_car": clientCar,
      "products_quantities": products?.map((p) {
        return {"product": p.getId(), "quantity": 1};
      }).toList(),
    };

    data.removeWhere((key, value) => value == null);

    return data;
  }
}
